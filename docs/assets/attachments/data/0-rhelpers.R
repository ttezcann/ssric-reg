# Helpers---

.run_with_viewer_feedback <- function(expr) {
  if (exists(".with_feedback", mode = "function")) {
    .with_feedback(expr)
  } else {
    force(expr)}}

.run_with_viewer_success <- function(expr, label = NULL, show_counts = TRUE) {
  if (exists(".with_feedback", mode = "function")) {
    .with_feedback(expr, show_success = TRUE, label = label, show_counts = show_counts)
  } else {
    force(expr)}}

## check missing first argument ----
.check_first_argument <- function(args) {
  arg_names <- names(args)
  first_argument_missing <- length(args) == 0 || (!is.null(arg_names) && length(arg_names) >= 1 && nzchar(arg_names[1]))
  if (first_argument_missing) stop("Code arguments are missing.", call. = FALSE)}

## check wrong variable names inside expressions ----
.check_variable_references <- function(expr, env = parent.frame()) {
  missing_vars <- character(0)

  check_expr <- function(e) {
    if (is.call(e)) {
      if (identical(e[[1]], as.name("$")) && length(e) == 3) {
        data_obj <- try(eval(e[[2]], env), silent = TRUE)
        var_name <- as.character(e[[3]])
        if (!inherits(data_obj, "try-error") && !is.null(names(data_obj)) && !var_name %in% names(data_obj)) missing_vars <<- c(missing_vars, var_name)}

      if (identical(e[[1]], as.name("[[")) && length(e) >= 3) {
        data_obj <- try(eval(e[[2]], env), silent = TRUE)
        var_name <- try(eval(e[[3]], env), silent = TRUE)
        if (!inherits(data_obj, "try-error") && !inherits(var_name, "try-error") && is.character(var_name) && length(var_name) == 1 && !is.null(names(data_obj)) && !var_name %in% names(data_obj)) missing_vars <<- c(missing_vars, var_name)}

      for (i in seq_along(e)[-1]) check_expr(e[[i]])}}

  check_expr(expr)
  missing_vars <- unique(missing_vars)
  if (length(missing_vars) > 0) stop(paste0("These variables do not exist: ", paste(missing_vars, collapse = ", ")), call. = FALSE)}

## frequency table----
frq <- function(x, ..., out = "v") {
  .run_with_viewer_feedback({
    result <- sjmisc::frq(x, out = out, ...)
    for (i in seq_along(result)) {
      if ("val" %in% names(result[[i]])) names(result[[i]])[names(result[[i]]) == "val"] <- "value"
      if ("label" %in% names(result[[i]])) names(result[[i]])[names(result[[i]]) == "label"] <- "value label"
      lbl <- attr(result[[i]], "label")
      if (!is.null(lbl)) attr(result[[i]], "label") <- paste0(gsub("\\s*\\(x\\)\\s*", "", lbl), " (Variable label)")
      attr(result[[i]], "vartype") <- "" }
    result })}

## descriptive table----
descr <- function(x, ..., show = "short", out = "v") {
  .run_with_viewer_feedback({
    x_expr <- substitute(x)
    x_name <- deparse(x_expr)
    var_name <- sub(".*\\$", "", x_name)
    x_value <- eval.parent(x_expr)
    var_label <- attr(x_value, "label")
    dat <- data.frame(tmp = x_value, check.names = FALSE)
    names(dat) <- var_name
    if (!is.null(var_label)) attr(dat[[var_name]], "label") <- var_label
    if (identical(show, "short")) show <- c("n", "label", "NA.prc", "mean", "sd")
    result <- sjmisc::descr(dat, out = out, show = show, ...)
    if ("var" %in% names(result)) names(result)[names(result) == "var"] <- "variable"
    if ("label" %in% names(result)) names(result)[names(result) == "label"] <- "variable label"
    result })}

## plot frequency ----
plot_frq <- function(...) {
  .run_with_viewer_feedback({
    args <- list(...)
    .check_first_argument(args)
    sjPlot::plot_frq(...)})}

## chisquare----
sjt.xtab <- function(...) {
  .run_with_viewer_feedback({
    result <- sjPlot::sjt.xtab(...)
    add_stars_to_html <- function(html) {
      if (is.null(html) || !nzchar(html)) return(html)
      pattern <- "p(=|&lt;|<)([0-9]*\\.?[0-9]+)"
      m <- gregexpr(pattern, html)
      matches <- regmatches(html, m)[[1]]
      if (length(matches) > 0) {
        replacements <- vapply(matches, function(match) {
          is_less_than <- grepl("&lt;|<", match) && !grepl("^p=", match)
          num_str <- sub("p(=|&lt;|<)", "", match)
          p_val <- suppressWarnings(as.numeric(num_str))
          if (is.na(p_val)) return(match)
          if (is_less_than) p_val <- p_val - 1e-10
          stars <- if (p_val < .001) "***" else if (p_val < .01) "**" else if (p_val < .05) "*" else ""
          display <- if (is_less_than) "p=0.000" else match
          paste0(display, stars) }, character(1))
        regmatches(html, m)[[1]] <- replacements }
      html }
    if (!is.null(result$knitr)) result$knitr <- add_stars_to_html(result$knitr)
    if (!is.null(result$page.content)) result$page.content <- add_stars_to_html(result$page.content)
    if (!is.null(result$page.complete)) result$page.complete <- add_stars_to_html(result$page.complete)
    result })}

## t.test ----
t.test <- function(x, ...) {
  .run_with_viewer_feedback({
    result <- stats::t.test(x, ...)
    args <- list(...)
    if (inherits(x, "formula") && !is.null(args$data)) {
      vars <- all.vars(x)
      outcome_name <- vars[1]
      group_name <- vars[2]
      outcome_var <- args$data[[outcome_name]]
      group_var <- args$data[[group_name]]
      outcome_label <- attr(outcome_var, "label")
      if (!is.null(outcome_label) && nzchar(outcome_label)) result$data.name <- sub(outcome_name, outcome_label, result$data.name, fixed = TRUE)
      value_labels <- attr(group_var, "labels")
      if (!is.null(value_labels) && !is.null(result$estimate)) {
        est_names <- names(result$estimate)
        code_to_label <- setNames(names(value_labels), as.character(unname(value_labels)))
        new_names <- est_names
        for (i in seq_along(est_names)) {
          nm <- est_names[i]
          m <- regexec("^mean in group (.+)$", nm)
          regmatch <- regmatches(nm, m)[[1]]
          if (length(regmatch) > 1) {
            grp_code <- regmatch[2]
            if (grp_code %in% names(code_to_label)) new_names[i] <- paste0(code_to_label[[grp_code]]) } }
        names(result$estimate) <- new_names } }
    result })}

### parameters ----
parameters <- function(model, ...) {
  .run_with_viewer_feedback({
    out <- parameters::model_parameters(model, ...)
    if ("p" %in% names(out)) {
      out$Sig <- base::ifelse(out$p < .001, "***", base::ifelse(out$p < .01, "**", base::ifelse(out$p < .05, "*", "")))
      attr(out, "raw_p") <- out$p }
    out })}

### display ----
display <- function(object, ...) {
  .run_with_viewer_feedback({
    result <- parameters::display(object, ...)
    if (inherits(result, "gt_tbl")) {
      result <- gt::tab_header(result, title = NULL, subtitle = NULL)
      result$`_source_notes` <- list()
      raw_p <- attr(object, "raw_p")
      if (!is.null(raw_p)) {
        for (p in raw_p) {
          stars <- if (p < .001) "***" else if (p < .01) "**" else if (p < .05) "*" else ""
          p_fmt <- formatC(p, digits = 3, format = "f")
          result$`_data`$p <- paste0(p_fmt, stars) } }
      if ("Sig" %in% names(result$`_data`)) result <- gt::cols_hide(result, columns = "Sig")
      result <- gt::cols_label(result, Parameter = "Outcome variable") }
    result })}

## correlation table----
tab_corr <- function(...) {
  .run_with_viewer_feedback({
    call_args <- as.list(substitute(list(...)))[-1]
    env <- parent.frame()

    if (length(call_args) >= 1) {
      first_arg <- call_args[[1]]

      if (is.call(first_arg) && identical(first_arg[[1]], as.name("["))) {
        data_expr <- first_arg[[2]]
        vars_expr <- if (length(first_arg) >= 4) first_arg[[4]] else first_arg[[3]]
        vars <- try(eval(vars_expr, env), silent = TRUE)

        if (is.character(vars)) {
          fixed_vars <- trimws(vars)
          data <- eval(data_expr, env)

          if (all(fixed_vars %in% names(data))) call_args[[1]] <- data[fixed_vars] } } }

    args <- lapply(call_args, eval, envir = env)
    result <- do.call(sjPlot::tab_corr, args)

    modify_html <- function(html) {
      if (is.null(html) || !nzchar(html)) return(html)
      p_pattern <- "\\((&lt;)?\\.([0-9]+)\\)"
      m <- gregexpr(p_pattern, html)
      matches <- regmatches(html, m)[[1]]
      if (length(matches) > 0) {
        replacements <- vapply(matches, function(match) {
          is_less_than <- grepl("&lt;", match)
          num_str <- sub("\\((&lt;)?\\.", "0.", sub("\\)$", "", match))
          p_val <- suppressWarnings(as.numeric(num_str))
          if (is.na(p_val)) return(match)
          if (is_less_than) p_val <- p_val - 1e-10
          stars <- if (p_val < .001) "***" else if (p_val < .01) "**" else if (p_val < .05) "*" else ""
          if (is_less_than) paste0("p = 0.000", stars) else paste0("p = 0", sub("^\\(", "", sub("\\)$", "", match)), stars) }, character(1))
        regmatches(html, m)[[1]] <- replacements }
      r_pattern <- "(<td[^>]*class=\"tdata[^\"]*\"[^>]*>)(-?[01]?\\.[0-9]{2,3})(<br)"
      html <- gsub(r_pattern, "\\1r = \\2\\3", html)
      html }
    if (!is.null(result$knitr)) result$knitr <- modify_html(result$knitr)
    if (!is.null(result$page.content)) result$page.content <- modify_html(result$page.content)
    if (!is.null(result$page.complete)) result$page.complete <- modify_html(result$page.complete)
    result })}

## select variables safely ----
select_vars <- function(data, vars) {
  .run_with_viewer_feedback({
    fixed_vars <- trimws(vars)

    if (!all(fixed_vars %in% names(data))) {
      missing_vars <- fixed_vars[!fixed_vars %in% names(data)]
      stop(paste0("These variables do not exist: ", paste(missing_vars, collapse = ", ")), call. = FALSE) }

    data[fixed_vars] })}

## correlation scatterplot----
scatterplot <- function(data, xvar, yvar) {
  .run_with_viewer_feedback({
    xvar <- trimws(xvar)
    yvar <- trimws(yvar)
    missing_vars <- c(xvar, yvar)[!c(xvar, yvar) %in% names(data)]
    if (length(missing_vars) > 0) stop(paste0("These variables do not exist: ", paste(missing_vars, collapse = ", ")), call. = FALSE)
    if (!is.numeric(data[[xvar]])) stop(paste0("Variable `", xvar, "` is not numeric."), call. = FALSE)
    if (!is.numeric(data[[yvar]])) stop(paste0("Variable `", yvar, "` is not numeric."), call. = FALSE)
    ok <- stats::complete.cases(data[[xvar]], data[[yvar]])
    test <- stats::cor.test(data[[xvar]][ok], data[[yvar]][ok])
    stars <- if (test$p.value < .001) "***" else if (test$p.value < .01) "**" else if (test$p.value < .05) "*" else ""
    label_text <- paste0("r = ", formatC(unname(test$estimate), format = "f", digits = 3), ", p = ", formatC(test$p.value, format = "f", digits = 3), stars)
    ggpubr::ggscatter(data, x = xvar, y = yvar, add = "loess", conf.int = TRUE, point = FALSE,
      xlab = sjlabelled::get_label(data[[xvar]], def.value = xvar),
      ylab = sjlabelled::get_label(data[[yvar]], def.value = yvar)) +
      ggplot2::annotate("text", x = -Inf, y = Inf, label = label_text, hjust = -0.1, vjust = 1.2) })}

## Scatterplot matrix with p-values----
pairs_panels_pval <- function(...) {
  .run_with_viewer_feedback({
    args <- list(...)
    .check_first_argument(args)
    data <- args[[1]]
    color <- if (!is.null(args$color)) args$color else "#1a5490"
    smooth <- if (!is.null(args$smooth)) args$smooth else TRUE
    ci <- if (!is.null(args$ci)) args$ci else FALSE
    max_points <- if (!is.null(args$max_points)) args$max_points else 1000
    cex_text <- if (!is.null(args$cex_text)) args$cex_text else 1.6
    other_args <- args[-1]
    other_args$color <- NULL
    other_args$smooth <- NULL
    other_args$ci <- NULL
    other_args$max_points <- NULL
    other_args$cex_text <- NULL
    upper_panel <- function(x, y, ...) {
      usr <- par("usr"); on.exit(par(usr))
      par(usr = c(0, 1, 0, 1))
      ok <- complete.cases(x, y)
      test <- suppressWarnings(cor.test(x[ok], y[ok]))
      r <- test$estimate
      p <- test$p.value
      r_txt <- paste0("r=", formatC(r, digits = 3, format = "f"))
      stars <- if (p < .001) "***" else if (p < .01) "**" else if (p < .05) "*" else ""
      p_txt <- paste0("p=", formatC(p, digits = 3, format = "f"))
      text(0.5, 0.62, r_txt, cex = cex_text, col = "black")
      text(0.5, 0.30, paste0(p_txt, stars), cex = cex_text, col = "gray25") }
    diag_panel <- function(x, ...) {
      usr <- par("usr"); on.exit(par(usr))
      par(usr = c(usr[1:2], 0, 1.5))
      h <- hist(x, plot = FALSE)
      rect(h$breaks[-length(h$breaks)], 0, h$breaks[-1], h$counts / max(h$counts), col = color, border = "white") }
    lower_panel <- function(x, y, ...) {
      ok <- complete.cases(x, y)
      if (sum(ok) < 3 || !smooth) return(invisible())
      xo <- x[ok]; yo <- y[ok]
      n <- length(xo)
      if (n > max_points) { idx <- sample.int(n, max_points); xs <- xo[idx]; ys <- yo[idx] } else { xs <- xo; ys <- yo }
      fit <- try(loess(ys ~ xs, span = 0.75, degree = 1), silent = TRUE)
      if (inherits(fit, "try-error")) return(invisible())
      ord <- order(xs)
      lines(xs[ord], fitted(fit)[ord], col = color, lwd = 2.5)
      if (ci) {
        pred <- predict(fit, se = TRUE)
        lines(xs[ord], (pred$fit + 1.96 * pred$se.fit)[ord], col = color, lty = 2, lwd = 1)
        lines(xs[ord], (pred$fit - 1.96 * pred$se.fit)[ord], col = color, lty = 2, lwd = 1) }
      rm(fit, xs, ys); invisible(gc(verbose = FALSE)) }
    do.call(pairs, c(list(x = data, upper.panel = upper_panel, lower.panel = lower_panel, diag.panel = diag_panel, gap = 0.3), other_args)) })}

## tab_model ----
tab_model <- function(...) {
  .run_with_viewer_feedback({
    call <- match.call(expand.dots = TRUE)
    call[[1]] <- quote(sjPlot::tab_model)
    args <- list(...)
    models <- Filter(function(a) inherits(a, c("lm", "glm")), args)
    is_logit <- any(vapply(models, function(m) {
      inherits(m, "glm") && isTRUE(m$family$family == "binomial")
    }, logical(1)))
    if (is.null(call$string.pred)) call$string.pred <- "Factors"
    if (is.null(call$string.est) && !is_logit) call$string.est <- "Coeff."
    if (is.null(call$string.std)) call$string.std <- if (is_logit) "std. OR" else "std. Coeff."
    call$p.style <- "numeric"
    result <- eval(call, envir = parent.frame())
    add_stars_to_p <- function(html) {
      if (is.null(html) || !nzchar(html)) return(html)
      cell_pattern <- "<td class=\"tdata centeralign modelcolumn[0-9]+ col4\">[^<]*(<strong>)?(&lt;)?([0-9]*\\.[0-9]+)(</strong>)?</td>"
      m <- gregexpr(cell_pattern, html)
      matches <- regmatches(html, m)[[1]]
      if (length(matches) > 0) {
        replacements <- vapply(matches, function(match) {
          is_less_than <- grepl("&lt;", match)
          num_str <- sub(".*?(&lt;)?([0-9]*\\.[0-9]+).*", "\\2", match)
          p_val <- suppressWarnings(as.numeric(num_str))
          if (is.na(p_val)) return(match)
          if (is_less_than) p_val <- p_val - 1e-10
          stars <- if (p_val < .001) "***" else if (p_val < .01) "**" else if (p_val < .05) "*" else ""
          cell_open <- sub("(<td[^>]*>).*", "\\1", match)
          if (nzchar(stars)) paste0(cell_open, "<strong>", formatC(p_val + if (is_less_than) 1e-10 else 0, digits = 3, format = "f"), stars, "</strong></td>")
          else paste0(cell_open, formatC(p_val, digits = 3, format = "f"), "</td>") }, character(1))
        regmatches(html, m)[[1]] <- replacements }
      html <- gsub("([A-Za-z])'([A-Za-z])", "\\1' \\2", html)
      html }
    if (!is.null(result$knitr)) result$knitr <- add_stars_to_p(result$knitr)
    if (!is.null(result$page.content)) result$page.content <- add_stars_to_p(result$page.content)
    if (!is.null(result$page.complete)) result$page.complete <- add_stars_to_p(result$page.complete)
    result })}

.show_result_viewer <- function(result, title = "Result") {
  if (!rstudioapi::isAvailable()) return(invisible())

  result_text <- paste(capture.output(print(result)), collapse = "\n")

  .show_viewer(paste0(
    "<h3 style='color:#2a7a2a'>", title, "</h3>",
    "<pre style='background:#f5f5f5;padding:10px;color:#000000;",
    "white-space:pre-wrap;overflow-wrap:anywhere'>",
    result_text,
    "</pre>"
  ))
}


## other sjPlot and performance wrappers ----
plot_stackfrq <- function(...) {
  .run_with_viewer_feedback({
    args <- list(...)
    .check_first_argument(args)
    sjPlot::plot_stackfrq(...)})}

plot_xtab <- function(...) {
  .run_with_viewer_feedback({
    args <- list(...)
    .check_first_argument(args)
    sjPlot::plot_xtab(...)})}

check_model <- function(...) {
  .run_with_viewer_feedback({
    args <- list(...)
    .check_first_argument(args)
    performance::check_model(...)})}

check_heteroscedasticity <- function(...) {
  .run_with_viewer_feedback({
    args <- list(...)
    .check_first_argument(args)

    result <- performance::check_heteroscedasticity(...)
    .show_result_viewer(result, title = "Heteroscedasticity check")
    result
  })
}

check_collinearity <- function(...) {
  .run_with_viewer_feedback({
    args <- list(...)
    .check_first_argument(args)

    result <- performance::check_collinearity(...)
    .show_result_viewer(result, title = "Collinearity check")
    result
  })
}

## ifelse - dummy variable labeling----
ifelse <- function(test, yes, no, label = NULL) {
  test_expr <- substitute(test)
  env <- parent.frame()
  result <- .run_with_viewer_feedback({
    .check_variable_references(test_expr, env)
    base::ifelse(test, yes, no)})
  if (!is.null(label)) attr(result, "label") <- label
  result}

## structure - variable labeling----
structure <- function(.Data, ..., label = NULL) {
  result <- .run_with_viewer_feedback({
    base::structure(.Data, ...)})
  if (!is.null(label)) attr(result, "label") <- label
  result}

## rec with viewer success ----
rec <- function(x, rec, var.label = NULL, ...) {
  x_expr <- substitute(x)
  env <- parent.frame()
  result <- .run_with_viewer_feedback({
    .check_variable_references(x_expr, env)
    sjmisc::rec(x, rec = rec, var.label = var.label, ...)})
  if (!is.null(var.label)) attr(result, "label") <- var.label
  result}

## viewer feedback helpers (internal) ----

.current_warnings <- character(0)
.viewer_error_shown <- FALSE

.clean_msg <- function(msg) {
  msg <- gsub("\033\\[[0-9;]*m", "", msg)
  msg <- gsub("â€¢|â„¹|âœ–|â—‡|â—†", "", msg)
  msg <- gsub("[^\x20-\x7E\n]", "", msg)
  msg <- gsub("<", "&lt;", msg, fixed = TRUE)
  msg <- gsub(">", "&gt;", msg, fixed = TRUE)
  msg}

.show_viewer <- function(html) {
  if (!rstudioapi::isAvailable()) return(invisible())
  tmp <- tempfile(fileext = ".html")
  writeLines(paste0(
    "<html><body style='font-family:sans-serif;padding:20px'>",
    html,
    "</body></html>"), tmp)
  rstudioapi::viewer(tmp)}

## variable creation success ----
.call_name <- function(expr) {
  if (!is.call(expr)) return("")
  deparse(expr[[1]])}

.is_variable_success_call <- function(expr) {
  is.call(expr) && .call_name(expr) %in% c("rec", "ifelse", "structure")}

.is_structure_rowmeans_call <- function(expr) {
  is.call(expr) && .call_name(expr) == "structure" && length(expr) >= 2 &&
    is.call(expr[[2]]) && .call_name(expr[[2]]) == "rowMeans"}

.get_lhs_variable_name <- function(expr) {
  lhs <- expr[[2]]
  if (is.call(lhs) && .call_name(lhs) == "$") return(deparse(lhs[[3]]))
  deparse(lhs)}

if (!"variable_created_success_callback" %in% names(getTaskCallbackNames())) {
  addTaskCallback(function(expr, value, ok, visible) {
    if (!ok || !is.call(expr) || length(expr) < 3) return(TRUE)
    if (deparse(expr[[1]]) %in% c("<-", "=") && .is_variable_success_call(expr[[3]])) {
      .show_success(value, attr(value, "label"), !.is_structure_rowmeans_call(expr[[3]]), .get_lhs_variable_name(expr))}
    TRUE
  }, name = "variable_created_success_callback")}

.get_recent_warnings <- function() {
  if (length(.current_warnings) == 0) return("")
  paste(.current_warnings, collapse = "\n")}

.with_feedback <- function(expr, show_success = FALSE, label = NULL, show_counts = TRUE, variable_name = NULL) {
  .current_warnings <<- character(0)
  .viewer_error_shown <<- FALSE

  result <- tryCatch(
    withCallingHandlers(
      expr,
      warning = function(w) {
        .current_warnings <<- c(.current_warnings, conditionMessage(w))}),
    error = function(e) {
      .show_error(e)
      stop(e)})

  if (length(.current_warnings) > 0) .show_warning()
  if (show_success) .show_success(result, label, show_counts, variable_name)
  result}

.extract_backtick_names <- function(source_msg) {
  names <- unlist(regmatches(source_msg, gregexpr("`[^`]*`", source_msg)))
  names <- unique(names)
  names <- names[names != ""]
  names <- names[!names %in% c("``", "`NA`", "`NULL`", "`TRUE`", "`FALSE`")]
  names}

.extract_object_not_found_names <- function(source_msg) {
  object_names <- unlist(regmatches(
    source_msg,
    gregexpr("object '[^']+' not found", source_msg)))
  object_names <- gsub("object '", "", object_names, fixed = TRUE)
  object_names <- gsub("' not found", "", object_names, fixed = TRUE)
  object_names <- unique(object_names)
  object_names <- object_names[object_names != ""]
  object_names <- object_names[!object_names %in% c("NA", "NULL", "TRUE", "FALSE")]
  object_names}

.extract_function_name <- function(source_msg) {
  function_name <- unlist(regmatches(
    source_msg,
    regexpr("could not find function \"[^\"]+\"", source_msg)))
  function_name <- gsub("could not find function \"", "", function_name)
  function_name <- gsub("\"", "", function_name)
  function_name}

.is_probably_data_name <- function(x) {
  if (length(x) == 0) return(FALSE)
  x <- gsub("`", "", x)
  x %in% c("gs", "gss", "gsss", "gss1", "gss2") | adist(x, "gss") <= 2}

.extract_variable_names <- function(source_msg) {
  variable_names <- character(0)

  unknown_column_lines <- unlist(regmatches(
    source_msg,
    gregexpr("Unknown or uninitialised column: `[^`]+`", source_msg)))
  variable_names <- c(variable_names, .extract_backtick_names(
    paste(unknown_column_lines, collapse = "\n")))

  column_missing_lines <- unlist(regmatches(
    source_msg,
    gregexpr("Column[s]? .*don't exist\\.|Column `[^`]+` doesn't exist", source_msg)))
  variable_names <- c(variable_names, .extract_backtick_names(
    paste(column_missing_lines, collapse = "\n")))

  select_missing_lines <- unlist(regmatches(
    source_msg,
    gregexpr("Can't select columns that don't exist\\.[\\s\\S]*", source_msg)))
  variable_names <- c(variable_names, .extract_backtick_names(
    paste(select_missing_lines, collapse = "\n")))

  subset_missing_lines <- unlist(regmatches(
    source_msg,
    gregexpr("Can't subset columns that don't exist\\.[\\s\\S]*", source_msg)))
  variable_names <- c(variable_names, .extract_backtick_names(
    paste(subset_missing_lines, collapse = "\n")))

  these_missing_lines <- unlist(regmatches(
    source_msg,
    gregexpr("These variables do not exist: .*", source_msg)))
  if (length(these_missing_lines) > 0) {
    these_vars <- gsub("These variables do not exist: ", "", these_missing_lines)
    these_vars <- unlist(strsplit(these_vars, ",\\s*"))
    these_vars <- paste0("`", these_vars, "`")
    variable_names <- c(variable_names, these_vars)}

  object_vars <- .extract_object_not_found_names(source_msg)
  object_vars <- object_vars[!.is_probably_data_name(object_vars)]
  object_vars <- object_vars[!object_vars %in% c("NA", "NULL", "TRUE", "FALSE")]
  object_vars <- paste0("`", object_vars, "`")

  bad_phrases <- c("`t subset columns that don`", "`t select columns that don`")
  variable_names <- unique(c(variable_names, object_vars))
  variable_names <- variable_names[!variable_names %in% bad_phrases]
  variable_names <- variable_names[!variable_names %in% c("``", "`NA`", "`NULL`", "`TRUE`", "`FALSE`")]
  variable_names <- variable_names[variable_names != ""]
  variable_names}

.extract_variables_with_spaces <- function(variable_names) {
  raw_names <- gsub("^`|`$", "", variable_names)
  spaced_names <- variable_names[raw_names != trimws(raw_names)]
  spaced_names}

.data_name_warning <- function(msg) {
  recent_warnings <- .clean_msg(.get_recent_warnings())
  combined_msg <- paste(msg, recent_warnings, sep = "\n")

  object_names <- .extract_object_not_found_names(combined_msg)
  data_names <- object_names[.is_probably_data_name(object_names)]

  if (length(data_names) == 0) return("")

  data_names <- unique(data_names)

  data_text <- if (length(data_names) == 1) {
    paste0("There is no dataset loaded with this name: ", data_names, ".")
  } else {
    paste0(
      "There are no datasets loaded with these names: ",
      paste(data_names, collapse = ", "),
      ".")}

  paste0(
    "<hr>",
    "<h3 style='color:#cc0000'>&#9888; Data name problem</h3>",
    "<p><b>Problem found:</b></p>",
    "<pre style='background:#f5f5f5;padding:10px;color:#cc0000;",
    "white-space:pre-wrap;overflow-wrap:anywhere'>",
    data_text,
    "</pre>",
    "<p>Check <b>Environment &gt; Data</b>.</p>",
    "<p>This error happens for one of these reasons:</p>",
    "<ol>",
    "<li>The dataset name was typed incorrectly.</li>",
    "<li>The dataset was not loaded yet. Go to the top of this R Script file, highlight and run the ",
    "&ldquo;Refresh data and packages&rdquo; code.</li>",
    "</ol>")}

.model_name_warning <- function(msg) {
  recent_warnings <- .clean_msg(.get_recent_warnings())
  combined_msg <- paste(msg, recent_warnings, sep = "\n")

  object_names <- .extract_object_not_found_names(combined_msg)
  model_names <- object_names[grepl("^model[0-9]*$", object_names)]

  if (length(model_names) == 0) return("")

  model_names <- unique(model_names)

  model_text <- if (length(model_names) == 1) {
    paste0("This model object does not exist: ", model_names, ".")
  } else {
    paste0("These model objects do not exist: ", paste(model_names, collapse = ", "), ".")}

  paste0(
    "<hr>",
    "<h3 style='color:#cc0000'>&#9888; Model name problem</h3>",
    "<p><b>Problem found:</b></p>",
    "<pre style='background:#f5f5f5;padding:10px;color:#cc0000;",
    "white-space:pre-wrap;overflow-wrap:anywhere'>",
    model_text,
    "</pre>",
    "<p>This error happens when the model name used later does not match the model name created earlier.</p>",
    "<ol>",
    "<li>Go back to the model code and compare the model name.</li>",
    "<li>For example, if you created <code>model1</code>, then use <code>model1</code> in the next line</li>",
    "</ol>")}

.variable_name_warning <- function(msg) {
  recent_warnings <- .clean_msg(.get_recent_warnings())

  variable_problem_pattern <- paste0(
    "Unknown or uninitialised column:|",
    "Column[s]? .*don't exist|",
    "Can't subset columns that don't exist|",
    "Can't select columns that don't exist|",
    "These variables do not exist:|",
    "object '[^']+' not found")

  error_has_variable_problem <- grepl(variable_problem_pattern, msg)
  warning_has_variable_problem <- grepl(variable_problem_pattern, recent_warnings)

  if (!error_has_variable_problem && !warning_has_variable_problem) return("")

  source_msg <- if (error_has_variable_problem) msg else recent_warnings
  variable_names <- .extract_variable_names(source_msg)
  variable_names <- variable_names[!gsub("`", "", variable_names) %in% c("gs", "gss", "gsss")]
  variable_names <- variable_names[!grepl("^model[0-9]*$", gsub("`", "", variable_names))]

  if (length(variable_names) == 0) return("")

  raw_variable_names <- gsub("`", "", variable_names)

  variable_text <- if (length(raw_variable_names) == 1) {
    paste0("This variable does not exist: ", raw_variable_names, ".")
  } else {
    paste0("These variables do not exist: ", paste(raw_variable_names, collapse = ", "), ".")}

  paste0(
    "<hr>",
    "<h3 style='color:#cc0000'>&#9888; Variable name problem</h3>",
    "<p><b>Problem found:</b></p>",
    "<pre style='background:#f5f5f5;padding:10px;color:#cc0000;",
    "white-space:pre-wrap;overflow-wrap:anywhere'>",
    variable_text,
    "</pre>",
    "<p>This error happens for one of these reasons:</p>",
    "<ol>",
    "<li>There is a typo in the variable name. Do not type variable names manually. ",
    "Copy and paste the variable name.</li>",
    "<li>If this is a recoded, computed, or dummy variable:",
    "<ol style='margin-top:6px'>",
    "<li>The prior codes were not highlighted and run, ",
    "so this variable doesn't exist in the dataset yet.",
    "<li>Preparing the code in the R Script file doesn't mean it's in the dataset; it must be highighted and run first.</li>",
    "<li>The further analyses that use this variable will not work until this code is fixed.</li>",
    "</ol>",
    "</li>",
    "</ol>")}

.package_problem_warning <- function(msg) {
  recent_warnings <- .clean_msg(.get_recent_warnings())
  combined_msg <- paste(msg, recent_warnings, sep = "\n")

  has_package_problem <- grepl("could not find function", combined_msg)
  if (!has_package_problem) return("")

  function_name <- .extract_function_name(combined_msg)

  problem_text <- if (length(function_name) > 0 && nzchar(function_name)) {
    paste0("Function `", function_name, "` does not exist.")
  } else {
    "The function does not exist."}

  paste0(
    "<hr>",
    "<h3 style='color:#cc0000'>&#9888; Package problem</h3>",
    "<p><b>Problem found:</b></p>",
    "<pre style='background:#f5f5f5;padding:10px;color:#cc0000;",
    "white-space:pre-wrap;overflow-wrap:anywhere'>",
    problem_text,
    "</pre>",
    "<p>This error happens for one of these reasons:</p>",
    "<ol>",
    "<li>There is a typo in the function name. Do not type the code manually. ",
    "Copy and paste the model code.</li>",
    "<li>The package that contains this function was not loaded. ",
    "Go to the top of this R Script file, highlight and run the ",
    "&ldquo;Refresh data and packages&rdquo; code.</li>",
    "</ol>")}

.incorrect_code_warning <- function(msg) {
  recent_warnings <- .clean_msg(.get_recent_warnings())
  combined_msg <- paste(msg, recent_warnings, sep = "\n")

has_incorrect_code_problem <- grepl(
  paste0(
    "Code arguments are missing|",
    "argument is missing|",
    "argument [0-9]+ is empty|",
    "missing argument|",
    "argument \"[^\"]+\" is missing|",
    "unused argument|",
    "unused arguments|",
    "unexpected symbol|",
    "unexpected string constant|",
    "unexpected numeric constant|",
    "unexpected '='|",
    "unexpected ','|",
    "unexpected '\\)'|",
    "unexpected '\\}'|",
    "unexpected end of input|",
    "unexpected EOF|",
    "incomplete final line|",
    "incomplete expression|",
    "no applicable method for 'select' applied to an object"),
  combined_msg)

  if (!has_incorrect_code_problem) return("")

  paste0(
    "<hr>",
    "<h3 style='color:#cc0000'>&#9888; Incorrect code problem</h3>",
    "<p><b>Problem found:</b></p>",
    "<pre style='background:#f5f5f5;padding:10px;color:#cc0000;",
    "white-space:pre-wrap;overflow-wrap:anywhere'>",
    "The code is incomplete. Code arguments are missing.",
    "</pre>",
    "<p>This error happens for one of these reasons:</p>",
    "<ol>",
    "<li>Something was accidentally deleted from or added to the code.</li>",
    "<li>A comma, quotation mark, parenthesis, semicolon, bracket, or a value is missing.</li>",
    "</ol>",
    "<p>Go back to the model code and compare this line.</p>")}

.problem_sections <- function(msg) {
  paste0(
    .data_name_warning(msg),
    .model_name_warning(msg),
    .variable_name_warning(msg),
    .package_problem_warning(msg),
    .incorrect_code_warning(msg))}

.error_checklist <- paste0(
  "<h3 style='color:#b8860b'>&#9888; There is a problem with the code!</h3>",
  "<p>Make sure to:</p>",
  "<ol>",
  "<li>Work on the correct R Script file.</li>",
  "<li>Use model code and working code.</li>",
  "<li>Follow the coding guidelines provided in the modules.</li>",
  "</ol>")

.show_error <- function(e) {
  .viewer_error_shown <<- TRUE
  msg <- .clean_msg(conditionMessage(e))
  recent_warnings <- .clean_msg(.get_recent_warnings())
  sections <- .problem_sections(msg)

  .show_viewer(paste0(
    .error_checklist,
    sections,
    if (!nzchar(sections)) paste0(
      "<hr><p><b>Error message:</b></p>",
      "<pre style='background:#f5f5f5;padding:10px;color:#cc0000;",
      "white-space:pre-wrap;overflow-wrap:anywhere'>",
      msg,
      "</pre>"
    ) else "",
    if (nzchar(recent_warnings) && !nzchar(sections)) paste0(
      "<hr><p><b>Warning message:</b></p>",
      "<pre style='background:#f5f5f5;padding:10px;color:#cc0000;",
      "white-space:pre-wrap;overflow-wrap:anywhere'>",
      recent_warnings,
      "</pre>"
    ) else ""))}

.show_warning <- function() {
  recent_warnings <- .clean_msg(.get_recent_warnings())
  if (!nzchar(recent_warnings)) return(invisible())

  sections <- .problem_sections("")

  .show_viewer(paste0(
    .error_checklist,
    sections,
    if (!nzchar(sections)) paste0(
      "<hr><p><b>Warning message:</b></p>",
      "<pre style='background:#f5f5f5;padding:10px;color:#cc0000;",
      "white-space:pre-wrap;overflow-wrap:anywhere'>",
      recent_warnings,
      "</pre>"
    ) else ""))}

.show_success <- function(result, label, show_counts = TRUE, variable_name = NULL) {
  .viewer_error_shown <<- FALSE
  lbl <- if (!is.null(label) && nzchar(label)) label else attr(result, "label")
  lbl <- if (!is.null(lbl) && nzchar(lbl)) lbl else "(no label)"
  numeric_result <- suppressWarnings(as.numeric(result))
  has_inf <- any(is.infinite(numeric_result), na.rm = TRUE)

  display_result <- if (is.numeric(numeric_result) && any(numeric_result != floor(numeric_result), na.rm = TRUE)) {
    round(numeric_result, 2)
  } else { result }

counts <- tryCatch({
  tbl <- table(display_result, useNA = "ifany")
  value_labels <- attr(result, "labels")
  value_names <- names(tbl)

  if (!is.null(value_labels)) {
    label_lookup <- setNames(names(value_labels), as.character(unname(value_labels)))
    label_names <- names(label_lookup)
    value_label_text <- ifelse(value_names %in% label_names, label_lookup[value_names], ifelse(value_names == "NA", "Missing", ""))
    missing_label_values <- label_names[!label_names %in% value_names]
    if (length(missing_label_values) > 0) {
      missing_tbl <- setNames(rep(0, length(missing_label_values)), missing_label_values)
      tbl <- c(tbl, missing_tbl)
      value_names <- names(tbl)
      value_label_text <- ifelse(value_names %in% label_names, label_lookup[value_names], ifelse(value_names == "NA", "Missing", ""))
      label_order <- c(label_names[label_names %in% value_names], setdiff(value_names, label_names))
      tbl <- tbl[label_order]
      value_names <- names(tbl)
      value_label_text <- ifelse(value_names %in% label_names, label_lookup[value_names], ifelse(value_names == "NA", "Missing", ""))
    }
  } else { value_label_text <- ifelse(value_names == "NA", "Missing", "") }

missing_row <- is.na(value_names) | value_names == "" | value_names == "NA"
valid_total <- sum(as.integer(tbl)[!missing_row])
valid_pct <- rep(NA_real_, length(tbl))
valid_pct[!missing_row] <- as.integer(tbl)[!missing_row] / valid_total * 100
valid_pct_text <- ifelse(missing_row, "", paste0(formatC(valid_pct, format = "f", digits = 1), "%"))

counts_df <- data.frame(Value = value_names, Label = value_label_text, Frequency = as.integer(tbl),
  valid.prc = valid_pct_text, check.names = FALSE)

  paste(capture.output(print(counts_df, row.names = FALSE)), collapse = "\n")
}, error = function(e) "(could not compute counts)")

if (has_inf) {
  .show_viewer(paste0(
    .error_checklist,
    "<hr>",
    "<h3 style='color:#cc0000'>&#9888; Incorrect code problem</h3>",
    "<p><b>Problem found:</b></p>",
    "<pre style='background:#f5f5f5;padding:10px;color:#cc0000;",
    "white-space:pre-wrap;overflow-wrap:anywhere'>",
    "The recoded variable contains invalid values (-Inf). ",
    "</pre>",
    "<p>This error happens when the recoding rules are not written correctly.</p>",
    "<ol>",
    "<li>Check whether all quotation marks, semicolons, parentheses, and brackets are closed correctly.</li>",
    "<li>This code should be fixed because RStudio still creates the variable, but the variable will incorrectly show <code>-Inf</code> in your analysis.</li>",
    "</ol>"))
  } else {
    variable_row <- if (!is.null(variable_name) && nzchar(variable_name)) paste0(
      "<tr><td style='padding:4px 12px 4px 0'><b>Variable name:</b></td>",
      "<td>", variable_name, "</td></tr>") else ""
    count_row <- if (isTRUE(show_counts)) paste0(
      "<tr><td style='padding:4px 12px 4px 0'><b>Value counts:</b></td>",
      "<td><pre style='margin:0;white-space:pre-wrap;overflow-wrap:anywhere'>",
      counts,
      "</pre></td></tr>") else ""
    .show_viewer(paste0(
      "<h3 style='color:#2a7a2a'>&#10003; Variable created successfully</h3>",
      "<table style='border-collapse:collapse;font-size:14px'>",
      variable_row,
      "<tr><td style='padding:4px 12px 4px 0'><b>Variable label:</b></td>",
      "<td>", lbl, "</td></tr>",
      count_row,
      "</table>"))}}

## make gss tolerate extra spaces in column names ----
`[.space_tolerant_data` <- function(x, i, j, ..., drop = FALSE) {
  if (missing(j) && !missing(i) && is.character(i)) {
    i <- trimws(i)
    missing_vars <- i[!i %in% names(x)]
    if (length(missing_vars) > 0) stop(paste0("These variables do not exist: ", paste(missing_vars, collapse = ", ")), call. = FALSE) }

  if (!missing(j) && is.character(j)) {
    j <- trimws(j)
    missing_vars <- j[!j %in% names(x)]
    if (length(missing_vars) > 0) stop(paste0("These variables do not exist: ", paste(missing_vars, collapse = ", ")), call. = FALSE) }

  NextMethod("[") }

make_space_tolerant_data <- function(data) {
  if (!inherits(data, "space_tolerant_data")) class(data) <- c("space_tolerant_data", class(data))
  data }

if (exists("gss", envir = .GlobalEnv)) {
  gss <- make_space_tolerant_data(gss) }

options(error = function() {
  if (.viewer_error_shown) {
    .viewer_error_shown <<- FALSE
    return(invisible())}

  .current_warnings <<- character(0)

  if (rstudioapi::isAvailable()) {
    msg <- .clean_msg(geterrmessage())
    sections <- .problem_sections(msg)
    tmp <- tempfile(fileext = ".html")

    writeLines(paste0(
      "<html><body style='font-family:sans-serif;padding:20px'>",
      .error_checklist,
      sections,
      if (!nzchar(sections)) paste0(
        "<hr><p><b>Error message:</b></p>",
        "<pre style='background:#f5f5f5;padding:10px;color:#cc0000;",
        "white-space:pre-wrap;overflow-wrap:anywhere'>",
        msg,
        "</pre>"
      ) else "",
      "</body></html>"), tmp)

    
    rstudioapi::viewer(tmp)}})