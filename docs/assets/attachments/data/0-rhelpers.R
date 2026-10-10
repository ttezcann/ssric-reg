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
    dots <- as.list(substitute(list(...)))[-1]
    dot_names <- names(dots)
    valid_dot_names <- c("max.length", "weights", "encoding", "file")
    unknown <- which(nzchar(dot_names) & !dot_names %in% valid_dot_names)
    if (length(unknown) > 0) stop(paste0("unused argument (", dot_names[unknown[1]], " = ",
      paste(deparse(dots[[unknown[1]]]), collapse = " "), ")"), call. = FALSE)
    show <- match.arg(show, c("all", "short", "type", "label", "n", "NA.prc", "mean", "sd",
      "se", "md", "trimmed", "range", "iqr", "skew"), several.ok = TRUE)
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
sjt.xtab <- function(..., wrap.labels = 50) {
  env <- parent.frame()
  .run_with_viewer_feedback({
    call_args <- as.list(substitute(list(...)))[-1]
    defaults <- formals(sjPlot::sjt.xtab)
    logical_options <- names(defaults)[vapply(defaults, is.logical, logical(1))]
    for (name in intersect(names(call_args), logical_options)) {
      argument <- call_args[[name]]
      if (is.symbol(argument) && !exists(as.character(argument), envir = env, inherits = TRUE)) {
        stop(paste0('Incorrect value for argument "', name, '".'), call. = FALSE)}}
    result <- sjPlot::sjt.xtab(..., wrap.labels = wrap.labels)
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
    .feedback_code_box(result_text, "#000000")
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
  result <- .run_with_viewer_success({
    .check_variable_references(test_expr, env)
    base::ifelse(test, yes, no)}, label = label)
  if (!is.null(label)) attr(result, "label") <- label
  result}

## structure - variable labeling----
structure <- function(.Data, ..., label = NULL) {
  result <- .run_with_viewer_success({
    base::structure(.Data, ...)}, label = label,
    show_counts = .call_name(substitute(.Data)) != "rowMeans")
  if (!is.null(label)) attr(result, "label") <- label
  result}

## rec with viewer success ----
.check_recode_rules <- function(rec) {
  rules <- trimws(regmatches(rec, gregexpr("[^;]+;?", rec))[[1]])
  for (rule in rules) {
    left <- trimws(sub("=.*$", "", rule))
    items <- trimws(strsplit(left, ",", fixed = TRUE)[[1]])
    malformed <- !nzchar(left) || any(!nzchar(items)) || any(vapply(items, function(item) {
      range <- trimws(strsplit(item, ":", fixed = TRUE)[[1]])
      if (grepl(":", item, fixed = TRUE)) {
        length(range) != 2 || any(!nzchar(range)) || any(grepl("[[:space:]]", range))
      } else grepl("[[:space:]]", item)
    }, logical(1)))
    if (malformed) stop(
      paste0("There's a problem in this line:\n", rule), call. = FALSE)}
  incomplete_rules <- rules[grepl("=\\s*(\\[[^]]*\\])?\\s*;?$", rules)]
  if (length(incomplete_rules) > 0) stop(
    paste0("There's a problem in this line:\n", incomplete_rules[1]), call. = FALSE)
  for (rule in rules) {
    rule_code <- rule
    labels <- gregexpr("\\[[^]]*\\]", rule_code)
    regmatches(rule_code, labels) <- lapply(regmatches(rule_code, labels),
      function(x) gsub("[^\r\n]", " ", x))
    next_rule <- regexpr("\r?\n[ \t]*[^=\\[\\]\r\n]+=", rule_code, perl = TRUE)[1]
    if (next_rule > 0) {
      lines <- trimws(strsplit(substr(rule, 1, next_rule - 1), "\n", fixed = TRUE)[[1]])
      stop(paste0("There's a problem in this line:\n", tail(lines[nzchar(lines)], 1)),
        call. = FALSE)}}
  closing_without_opening <- rules[
    lengths(regmatches(rules, gregexpr("]", rules, fixed = TRUE))) >
      lengths(regmatches(rules, gregexpr("[", rules, fixed = TRUE)))]
  if (length(closing_without_opening) > 0) stop(
    paste0("There's a problem in this line:\n", closing_without_opening[1]), call. = FALSE)
  problem_rules <- rules[lengths(regmatches(rules, gregexpr("[", rules, fixed = TRUE))) !=
    lengths(regmatches(rules, gregexpr("]", rules, fixed = TRUE)))]
  if (length(problem_rules) > 0) problem_rules[1] else NULL}

.check_recode_assignment <- function() {
  context <- .feedback_source()
  if (is.null(context)) return(invisible())
  for (selection in context$selection) {
    if (is.null(selection$text) || !nzchar(selection$text)) next
    lines <- strsplit(selection$text, "\n", fixed = TRUE)[[1]]
    nonblank <- which(nzchar(trimws(lines)))
    if (length(nonblank) < 2) next
    for (i in seq_len(length(nonblank) - 1)) {
      current <- trimws(lines[nonblank[i]])
      following <- trimws(lines[nonblank[i + 1]])
      if (grepl("^[[:alnum:]_.]+\\$[[:alnum:]_.]+$", current) &&
          grepl("^rec[[:space:]]*\\(", following)) {
        stop(paste0("There's a problem in this line:\n", current), call. = FALSE)}}}
  invisible()}

rec <- function(x, rec, var.label = NULL, ...) {
  x_expr <- substitute(x)
  env <- parent.frame()
  result <- .run_with_viewer_success({
    .check_recode_assignment()
    .check_variable_references(x_expr, env)
    problem_line <- .check_recode_rules(rec)
    result <- sjmisc::rec(x, rec = rec, var.label = var.label, ...)
    if (!is.null(problem_line) && any(is.infinite(suppressWarnings(as.numeric(result))), na.rm = TRUE)) {
      attr(result, ".recode_problem_line") <- problem_line
      attr(result, ".recode_problem_location") <- .resolve_feedback_location(fragment = problem_line)}
    result}, label = var.label)
  if (!is.null(var.label)) attr(result, "label") <- var.label
  result}

## viewer feedback helpers (internal) ----

.current_warnings <- character(0)
.viewer_error_shown <- FALSE
.feedback_depth <- 0L
.current_warning_location <- NULL
.last_parse_feedback <- NULL

## locate feedback in the student's current source ----
.feedback_source <- function() {
  tryCatch({
    for (frame in rev(sys.frames())) {
      if (!exists("srcfile", frame, inherits = FALSE)) next
      src <- get("srcfile", frame, inherits = FALSE)
      if (inherits(src, "srcfile") && !is.null(src$filename) && file.exists(src$filename)) {
        return(list(id = src$filename, path = src$filename,
          contents = if (!is.null(src$lines)) src$lines else readLines(src$filename, warn = FALSE),
          selection = list()))}}
    if (!requireNamespace("rstudioapi", quietly = TRUE) || !rstudioapi::isAvailable()) return(NULL)
    context <- rstudioapi::getSourceEditorContext()
    if (is.null(context$contents) || identical(context$id, "#console")) return(NULL)
    context
  }, error = function(e) NULL)}

.feedback_escape <- function(text) {
  text <- gsub("&", "&amp;", text, fixed = TRUE)
  text <- gsub("<", "&lt;", text, fixed = TRUE)
  gsub(">", "&gt;", text, fixed = TRUE)}

.feedback_parse <- function(lines) {
  src <- srcfilecopy("<student code>", lines)
  error <- NULL
  expressions <- tryCatch(parse(text = lines, srcfile = src, keep.source = TRUE),
    error = function(e) {error <<- conditionMessage(e); NULL})
  data <- getParseData(src, includeText = TRUE)
  if (is.null(data) && !is.null(error) && grepl("pipe", error, fixed = TRUE) &&
      any(grepl("|>", lines, fixed = TRUE))) {
    projected <- .feedback_parse(gsub("|>", "%>%", lines, fixed = TRUE))
    if (!is.null(projected$data)) return(projected)}
  list(data = data, error = error, expressions = expressions)}

.feedback_parse_line <- function(parsed, lines) {
  position <- regmatches(parsed$error, regexec(":([0-9]+):([0-9]+)(:|\\))", parsed$error))[[1]]
  if (length(position) < 3) return(NA_integer_)
  row <- as.integer(position[2])
  col <- as.integer(position[3])
  data <- parsed$data
  if (!is.null(data)) {
    tokens <- data[data$terminal & data$token != "COMMENT", ]
    tokens <- tokens[order(tokens$line1, tokens$col1), ]
    for (i in which(tokens$token == "STR_CONST" & tokens$line2 > tokens$line1)) {
      end <- tail(strsplit(tokens$text[i], "\n", fixed = TRUE)[[1]], 1)
      if (grepl("^[ \\t]*[.[:alpha:]][.[:alnum:]_]*[ \\t]*=[ \\t]*[\"']$", end)) {
        return(tokens$line2[i] - 1L)}}
    if (nrow(tokens) > 1) for (i in seq_len(nrow(tokens) - 1)) {
      if (tokens$token[i] == "SYMBOL" && exists(tokens$text[i], mode = "function") &&
          tokens$line1[i + 1] > tokens$line2[i] &&
          tokens$token[i + 1] %in% c("SYMBOL", "SYMBOL_SUB", "STR_CONST", "NUM_CONST")) {
        later <- tokens[tokens$line1 == tokens$line1[i + 1], ]
        if (!any(later$token == "LEFT_ASSIGN")) return(tokens$line1[i])}}
    for (i in which(tokens$token == "SYMBOL_FUNCTION_CALL")) {
      name <- tokens$text[i]
      if (exists(name, mode = "function") || nchar(name) < 2) next
      splits <- seq_len(nchar(name) - 1)
      joined <- vapply(splits, function(at) {
        exists(substr(name, 1, at), mode = "function") &&
          exists(substring(name, at + 1), mode = "function")}, logical(1))
      if (sum(joined) == 1) return(tokens$line1[i])}
    {
      stack <- character(0)
      delimiters <- character(0)
      opening_rows <- integer(0)
      for (i in seq_len(nrow(tokens))) {
        text <- tokens$text[i]
        if (text %in% c("(", "[", "[[")) {
          name <- if (text == "(" && i > 1) tokens$text[i - 1] else ""
          stack <- c(stack, name)
          delimiters <- c(delimiters, text)
          opening_rows <- c(opening_rows, tokens$line1[i])
        } else if (text %in% c(")", "]", "]]") && length(stack) > 0) {
          expected <- c(")" = "(", "]" = "[", "]]" = "[[")[[text]]
          if (tail(delimiters, 1) != expected) {
            return(if (text == "]") tokens$line1[i] else tail(opening_rows, 1))}
          stack <- head(stack, -1)
          delimiters <- head(delimiters, -1)
          opening_rows <- head(opening_rows, -1)
        } else if (row > length(lines) && (tokens$token[i] == "PIPE" || text == "%>%") && length(stack) > 0) {
          return(tokens$line1[i])
        } else if (row > length(lines) && tokens$token[i] == "SYMBOL_SUB" && length(stack) > 0) {
          name <- tail(stack, 1)
          if (!nzchar(name) || !exists(name, mode = "function")) next
          args <- names(formals(get(name, mode = "function")))
          parent <- if (length(stack) > 1) stack[length(stack) - 1] else ""
          parent_args <- if (nzchar(parent) && exists(parent, mode = "function")) {
            names(formals(get(parent, mode = "function")))} else character(0)
          if (!is.null(args) && (!"..." %in% args || text %in% parent_args) &&
              !text %in% args && i > 1) {
            return(tokens$line2[i - 1])}}}}
    before <- which(tokens$line1 < row | (tokens$line1 == row & tokens$col1 <= col))
    if (length(before) > 0) {
      i <- tail(before, 1)
      values <- c("SYMBOL", "SYMBOL_SUB", "STR_CONST", "NUM_CONST", "')'", "']'", "']]'", "'}'")
      if (i > 1 && tokens$token[i] %in% c("SYMBOL", "STR_CONST", "NUM_CONST") &&
          tokens$token[i - 1] %in% values) return(tokens$line2[i - 1])}}
  if (row > length(lines)) {
    nonblank <- which(nzchar(trimws(lines)))
    return(if (length(nonblank) > 0) tail(nonblank, 1) else NA_integer_)}
  row}

.resolve_feedback_location <- function(msg = "", fragment = NULL, calls = sys.calls(),
    context = .feedback_source()) {
  unknown <- list(line = NA_integer_, text = fragment)
  file_position <- regmatches(msg, regexec("(?m)^[ \t]*([^\n]+):([0-9]+):([0-9]+):", msg, perl = TRUE))[[1]]
  if (length(file_position) < 4) file_position <- regmatches(msg,
    regexec("\\(([^()\n]+):([0-9]+):([0-9]+)\\)", msg))[[1]]
  source_row <- NULL
  if (length(file_position) > 3 && file.exists(file_position[2])) {
    source_row <- as.integer(file_position[3])
    context <- list(id = file_position[2], path = file_position[2],
      contents = readLines(file_position[2], warn = FALSE), selection = list())}
  if (is.null(context) || length(context$contents) == 0) return(unknown)
  lines <- context$contents
  selected <- integer(0)
  cursor_rows <- integer(0)
  for (selection in context$selection) {
    if (!is.null(selection$range$start)) {
      cursor_rows <- c(cursor_rows, selection$range$start[1])}
    if (!is.null(selection$text) && nzchar(selection$text)) {
      first <- selection$range$start[1]
      last <- selection$range$end[1] - as.integer(selection$range$end[2] == 1)
      if (last >= first) selected <- c(selected, seq.int(first, last))}}

  is_parse <- grepl("unexpected |incomplete expression|incomplete final line|_R_USE_PIPEBIND_|pipe operator|RHS call of a pipe", msg)
  anchors <- character(0)
  if (is_parse) {
    numbered <- regmatches(msg, gregexpr("(?m)^[0-9]+: [^\n]*", msg, perl = TRUE))[[1]]
    if (length(numbered) > 0) anchors <- sub("^[0-9]+: ", "", numbered)
    if (grepl(" in:\n", msg, fixed = TRUE)) {
      anchors <- strsplit(sub("(?s)^.*? in:\n", "", msg, perl = TRUE), "\n", fixed = TRUE)[[1]]
      if (length(anchors) > 0) {
        anchors[1] <- sub('^"', "", anchors[1])
        anchors[length(anchors)] <- sub('"$', "", anchors[length(anchors)])}}
    if (length(anchors) == 0 && grepl(' in "', msg, fixed = TRUE)) {
      anchors <- sub('(?s)^.*? in "(.*)"\n?$', "\\1", msg, perl = TRUE)}
    anchors <- trimws(anchors[nzchar(trimws(anchors))])}
  if (is.null(fragment)) {
    detail <- regmatches(msg, regexpr("There's a problem in this line:\n[^\n]+", msg))
    if (length(detail) > 0) fragment <- sub("There's a problem in this line:\n", "", detail, fixed = TRUE)}
  unknown$text <- if (!is.null(fragment)) fragment else if (length(anchors) > 0) paste(anchors, collapse = "\n") else NULL

  diagnostic <- regmatches(msg, regexec("(?s)^Error in (.*?)[[:space:]]+:[[:space:]]*", msg, perl = TRUE))[[1]]
  if (length(diagnostic) > 1) {
    diagnostic_call <- tryCatch(parse(text = diagnostic[2])[[1]], error = function(e) NULL)
    if (is.call(diagnostic_call)) calls <- c(list(diagnostic_call), calls)}
  missing_function <- .extract_function_name(msg)
  missing_function_call <- length(missing_function) == 1 && any(vapply(Filter(is.call, calls),
    function(call) .call_name(call) == missing_function, logical(1)))
  incorrect_value <- regmatches(msg, regexec('Incorrect value for argument "([^"]+)"', msg))[[1]]
  validation_arguments <- if (length(incorrect_value) > 1) incorrect_value[2] else character(0)
  for (call in Filter(is.call, calls)) {
    if (.call_name(call) %in% c("match.arg", "base::match.arg") && length(call) >= 2 && is.symbol(call[[2]])) {
      validation_arguments <- c(validation_arguments, as.character(call[[2]]))}}

  nonblank <- which(nzchar(trimws(lines)))
  blocks <- unname(split(nonblank, cumsum(!nzchar(trimws(lines)))[nonblank]))
  if (length(selected) > 0) blocks <- c(list(selected), blocks)
  locations <- integer(0)
  data_locations <- integer(0)
  missing_data <- .extract_object_not_found_names(msg)
  missing_data <- missing_data[.is_probably_data_name(missing_data)]
  assignment_locations <- integer(0)
  pipe_locations <- integer(0)
  parenthesis_locations <- integer(0)
  missing_parenthesis <- regmatches(msg, regexec("as in .?([[:alnum:]_.]+)\\(\\)", msg))[[1]]
  if (!is.null(fragment) && nzchar(fragment)) {
    locations <- which(vapply(lines, function(line) grepl(fragment, line, fixed = TRUE), logical(1)))}
  call_keys <- unique(vapply(Filter(is.call, calls),
    function(call) paste(deparse(call, width.cutoff = 500), collapse = "\n"), character(1)))
  if (length(locations) == 0) {
    for (rows in blocks) {
      code <- lines[rows]
      parsed <- .feedback_parse(code)
      if (length(missing_parenthesis) > 1 && !is.null(parsed$data)) {
        bare_function <- parsed$data[parsed$data$terminal & parsed$data$token == "SYMBOL" &
          parsed$data$text == missing_parenthesis[2], ]
        for (row in unique(bare_function$line1)) {
          pattern <- paste0("^[[:space:]]*[[:alnum:]_.]+[[:space:]]*\\+[[:space:]]*",
            missing_parenthesis[2], "[[:space:]]*(#.*)?$")
          if (grepl(pattern, code[row])) parenthesis_locations <- c(parenthesis_locations, rows[row])}}
      if (is_parse) {
        related <- length(anchors) > 0 && all(vapply(anchors, function(anchor) {
          any(vapply(code, function(line) grepl(anchor, trimws(line), fixed = TRUE), logical(1)))}, logical(1)))
        if (!is.null(source_row) && source_row %in% rows) related <- TRUE
        if (length(anchors) == 0 && length(selected) > 0 && identical(rows, selected)) related <- TRUE
        if (!related || is.null(parsed$error)) next
        row <- .feedback_parse_line(parsed, code)
        if (!is.na(row) && row <= length(rows)) {
          locations <- c(locations, rows[row])
          if (identical(rows, selected)) break}
      } else if (!is.null(parsed$data) && (length(call_keys) > 0 || length(missing_function) > 0 ||
          grepl("non-numeric argument to binary operator|object '[^']+' not found|Code arguments are missing", msg))) {
        tokens <- parsed$data[parsed$data$terminal & parsed$data$token != "COMMENT", ]
        tokens <- tokens[order(tokens$line1, tokens$col1), ]
        next_token <- c(tail(tokens$token, -1), "")
        references <- tokens$token == "SYMBOL" & tokens$text %in% missing_data &
          !next_token %in% c("LEFT_ASSIGN", "EQ_ASSIGN")
        data_locations <- c(data_locations, rows[tokens$line1[references]])
        refs <- attr(parsed$expressions, "srcref")
        if (length(refs) > 1) for (j in seq.int(2, length(refs))) {
          previous <- parsed$expressions[[j - 1]]
          current <- parsed$expressions[[j]]
          if (!is.call(previous) || .call_name(previous) != "<-" ||
              !is.symbol(previous[[2]]) || !is.call(current)) next
          end <- refs[[j - 1]][3]
          start <- refs[[j]][1]
          if (start != end + 1L) next
          stage <- regmatches(trimws(code[start]), regexpr("^[[:alnum:]_.]+(?=\\()", trimws(code[start]), perl = TRUE))
          current_key <- paste(deparse(current, width.cutoff = 500), collapse = "\n")
          submitted <- current_key %in% call_keys || all(rows[start:refs[[j]][3]] %in% selected)
          if (identical(stage, "select") && identical(previous[[3]], as.name("gss"))) {
            first_arg <- regmatches(code[start], regexec("select\\([[:space:]]*([[:alnum:]_.]+)", code[start]))[[1]]
            missing <- .extract_object_not_found_names(msg)
            if (length(first_arg) > 1 && first_arg[2] != "gss" && first_arg[2] %in% missing && submitted) {
              pipe_locations <- c(pipe_locations, rows[end])}
          } else if (identical(stage, "plot_stackfrq") && .call_name(previous[[3]]) == "select" &&
              any(parsed$data$token == "PIPE" & parsed$data$line1 >= refs[[j - 1]][1] & parsed$data$line1 <= end) &&
              grepl("Code arguments are missing", msg, fixed = TRUE) && submitted) {
            pipe_locations <- c(pipe_locations, rows[end])}}
        expressions <- parsed$data[parsed$data$token == "expr" & nzchar(parsed$data$text), ]
        for (i in seq_len(nrow(expressions))) {
          expression <- tryCatch(parse(text = expressions$text[i])[[1]], error = function(e) NULL)
          if (!is.call(expression)) next
          key <- paste(deparse(expression, width.cutoff = 500), collapse = "\n")
          if (grepl("non-numeric argument to binary operator", msg, fixed = TRUE) &&
              .call_name(expression) == "-" && length(expression) == 3 &&
              is.call(expression[[2]]) && .call_name(expression[[2]]) == "$" &&
              identical(expression[[2]][[2]], as.name("gss")) &&
              is.symbol(expression[[2]][[3]]) && .call_name(expression[[3]]) == "rec") {
            lhs <- paste(deparse(expression[[2]]), collapse = " ")
            first_line <- gsub("[[:space:]]", "", code[expressions$line1[i]])
            prefix <- paste0("Error in ", lhs, " - rec(")
            if (identical(first_line, paste0(lhs, "-")) &&
                (key %in% call_keys || startsWith(gsub("[[:space:]]+", " ", msg), prefix))) {
              assignment_locations <- c(assignment_locations, rows[expressions$line1[i]])}}
          if (key %in% call_keys || (length(missing_function) == 1 && !missing_function_call &&
              .call_name(expression) == missing_function)) {
            row <- expressions$line1[i]
            names <- unique(c(.extract_object_not_found_names(msg),
              gsub("^`|`$", "", .extract_variable_names(msg)), missing_function, validation_arguments))
            if (grepl("unused arguments? \\(", msg)) {
              arguments <- sub("(?s)^.*unused arguments? \\((.*)\\)[[:space:]]*$", "\\1", msg, perl = TRUE)
              argument_call <- tryCatch(parse(text = paste0("list(", arguments, ")"))[[1]], error = function(e) NULL)
              if (is.call(argument_call)) names <- unique(c(names, names(as.list(argument_call)[-1])))}
            empty_argument <- regmatches(msg, regexec("argument ([0-9]+) is empty", msg))[[1]]
            if (length(empty_argument) > 1) {
              position <- as.integer(empty_argument[2])
              argument_names <- base::names(as.list(expression)[-1])
              if (!is.na(position) && position <= length(argument_names) &&
                  nzchar(argument_names[position])) {
                names <- unique(c(names, argument_names[position]))}}
            if (grepl("argument is missing|missing argument", msg)) {
              expression_arguments <- as.list(expression)[-1]
              argument_names <- base::names(expression_arguments)
              missing_positions <- which(vapply(expression_arguments,
                function(argument) identical(argument, quote(expr = )), logical(1)))
              missing_names <- argument_names[missing_positions]
              names <- unique(c(names, missing_names[nzchar(missing_names)]))}
            tokens <- parsed$data[parsed$data$terminal &
              parsed$data$line1 >= expressions$line1[i] & parsed$data$line2 <= expressions$line2[i], ]
            referenced <- unique(tokens$line1[tokens$text %in% c(names, paste0('"', names, '"'), paste0("`", names, "`"))])
            if (length(referenced) == 0 && .call_name(expression) %in% c("plot_frq", "sjPlot::plot_frq") &&
                grepl("no applicable method for 'select' applied to an object", msg, fixed = TRUE) &&
                requireNamespace("sjPlot", quietly = TRUE)) {
              formal_names <- setdiff(names(formals(sjPlot::plot_frq)), "...")
              supplied_names <- names(as.list(expression)[-1])
              unknown_names <- supplied_names[nzchar(supplied_names) & is.na(pmatch(supplied_names, formal_names))]
              typo_names <- unknown_names[vapply(unknown_names, function(name) {
                distances <- adist(name, formal_names)
                min(distances) <= 2 && sum(distances == min(distances)) == 1}, logical(1))]
              if (length(typo_names) == 1) referenced <- unique(tokens$line1[
                tokens$token == "SYMBOL_SUB" & tokens$text == typo_names])}
            if (length(referenced) == 1) row <- referenced
            locations <- c(locations, rows[row])}}}}}
  if (length(locations) == 0 && length(data_locations) > 0) locations <- data_locations
  if (length(assignment_locations) > 0) locations <- assignment_locations
  if (length(pipe_locations) > 0) locations <- pipe_locations
  if (length(parenthesis_locations) > 0) locations <- parenthesis_locations
  locations <- unique(locations)
  if (length(selected) > 0 && any(locations %in% selected)) locations <- locations[locations %in% selected]
  if (length(locations) > 1 && length(selected) == 0 && length(cursor_rows) > 0) {
    distances <- vapply(locations, function(row) min(abs(row - cursor_rows)), numeric(1))
    nearest <- locations[distances == min(distances)]
    if (length(nearest) == 1) locations <- nearest}
  if (length(locations) != 1) return(unknown)
  row <- locations[1]
  block <- Filter(function(rows) row %in% rows, blocks)
  block <- if (length(block) > 0) block[[1]] else row
  list(line = row, text = lines[row], block = range(block),
    incorrect_assignment = length(assignment_locations) > 0,
    incorrect_pipe = length(pipe_locations) > 0,
    incorrect_parenthesis = length(parenthesis_locations) > 0,
    document = paste(context$id, context$path, paste(lines, collapse = "\n"), sep = "\n"))}

.feedback_location_text <- function(location) {
  if (is.null(location) || is.na(location$line)) {
    return(paste0("Line number unavailable", if (!is.null(location$text)) paste0(":\n", location$text) else "."))}
  paste0("There's a problem on line ", location$line, ":\n", location$text)}

.feedback_code_box <- function(text, color = "#cc0000") {
  paste0("<pre style='background:#f5f5f5;padding:10px;color:", color, ";",
    "white-space:pre-wrap;overflow-wrap:anywhere'>", text, "</pre>")}

.problem_panel <- function(title, location, explanation = "", guidance = "") {
  paste0("<hr><h3 style='color:#cc0000'>&#9888; ", title, "</h3>",
    if (nzchar(explanation)) paste0("<p style='color:#000000'><b>", explanation, "</b></p>") else "",
    .problem_location_html(location), guidance)}

.problem_reasons <- function(...) {
  paste0("<p>This error happens for one of these reasons:</p><ol>",
    paste0("<li>", list(...), "</li>", collapse = ""), "</ol>")}

.name_problem_text <- function(names, singular, plural) {
  codes <- paste0("<code>", .feedback_escape(names), "</code>")
  paste0(if (length(names) == 1) singular else plural, paste(codes, collapse = ", "), ".")}

.problem_location_html <- function(location) {
  notice <- if (is.null(location) || is.na(location$line)) {
    "Line number unavailable"
  } else paste0(
    "There's a problem on ",
    "<span style='display:inline-block;background:#fff0a8;color:#8a1c00;",
    "padding:2px 7px;border-radius:4px'>line ", location$line, "</span>")
  code <- if (!is.null(location$text) && nzchar(location$text))
    .feedback_code_box(.feedback_escape(location$text)) else ""
  paste0(
    "<p style='color:#8a1c00;margin-bottom:8px'><b>", notice,
    " <span style='font-size:1.15em'>&#10132;</span></b></p>",
    code)}

.clean_msg <- function(msg) {
  msg <- gsub("\033\\[[0-9;]*m", "", msg)
  msg <- gsub("â€¢|â„¹|âœ–|â—‡|â—†", "", msg)
  msg <- gsub("[^\x20-\x7E\n]", "", msg)
  msg <- gsub("<", "&lt;", msg, fixed = TRUE)
  msg <- gsub(">", "&gt;", msg, fixed = TRUE)
  msg}

.show_viewer <- function(html) {
  tryCatch({
    if (!rstudioapi::isAvailable()) stop("RStudio Viewer is unavailable.", call. = FALSE)
    font_size <- tryCatch(rstudioapi::readRStudioPreference("font_size_points", 10),
      error = function(e) 10)
    if (!is.numeric(font_size) || length(font_size) != 1L || !is.finite(font_size) || font_size <= 0) font_size <- 10
    tmp <- tempfile(fileext = ".html")
    writeLines(paste0(
      "<html><head><style>",
      "body{font-family:sans-serif;font-size:", font_size, "pt;padding:20px}",
      "table,pre,code{font-size:inherit}h3{font-size:1.15em;font-weight:bold}",
      "</style></head><body>",
      html,
      "</body></html>"), tmp)
    rstudioapi::viewer(tmp)
    invisible(TRUE)
  }, error = function(e) {
    message("Viewer feedback could not be displayed: ", conditionMessage(e))
    message(gsub("<[^>]*>", " ", html))
    invisible(FALSE)})}

## variable creation success ----
.call_name <- function(expr) {
  if (!is.call(expr)) return("")
  paste(deparse(expr[[1]]), collapse = " ")}

.is_variable_success_call <- function(expr) {
  is.call(expr) && .call_name(expr) %in% c("rec", "ifelse", "structure")}

.is_structure_rowmeans_call <- function(expr) {
  is.call(expr) && .call_name(expr) == "structure" && length(expr) >= 2 &&
    is.call(expr[[2]]) && .call_name(expr[[2]]) == "rowMeans"}

.get_lhs_variable_name <- function(expr) {
  lhs <- expr[[2]]
  if (is.call(lhs) && .call_name(lhs) == "$") return(deparse(lhs[[3]]))
  deparse(lhs)}

.variable_created_success_callback <- function(expr, value, ok, visible) {
  on.exit({
    .current_warnings <<- character(0)
    .current_warning_location <<- NULL
    .last_parse_feedback <<- NULL
    .viewer_error_shown <<- FALSE}, add = TRUE)
  tryCatch({
    if (!ok || !is.call(expr) || length(expr) < 3) return(TRUE)
    if (.call_name(expr) %in% c("<-", "=") &&
        !.viewer_error_shown && length(.current_warnings) == 0) {
      if (is.symbol(expr[[2]]) && is.data.frame(value)) {
        .show_viewer(paste0(
          "<h3 style='color:#2a7a2a'>&#10003; Data created successfully: ",
          .feedback_escape(as.character(expr[[2]])), "</h3>"))
      } else if (.is_variable_success_call(expr[[3]])) {
        .show_success(value, attr(value, "label"), !.is_structure_rowmeans_call(expr[[3]]), .get_lhs_variable_name(expr))}}
  }, error = function(e) {
    message("Variable feedback failed: ", conditionMessage(e))
    tryCatch(.show_error(e), error = function(e) message(conditionMessage(e)))})
  TRUE}

.ensure_viewer_feedback <- function() {
  if (!"variable_created_success_callback" %in% getTaskCallbackNames()) {
    addTaskCallback(.variable_created_success_callback, name = "variable_created_success_callback")}
  options(error = .course_error_handler)
  invisible()}

.get_recent_warnings <- function() {
  if (length(.current_warnings) == 0) return("")
  paste(.current_warnings, collapse = "\n")}

.with_feedback <- function(expr, show_success = FALSE, label = NULL, show_counts = TRUE, variable_name = NULL) {
  if (.feedback_depth > 0L) return(force(expr))
  .ensure_viewer_feedback()
  .feedback_depth <<- .feedback_depth + 1L
  on.exit(.feedback_depth <<- .feedback_depth - 1L, add = TRUE)
  .current_warnings <<- character(0)
  .current_warning_location <<- NULL
  .last_parse_feedback <<- NULL
  .viewer_error_shown <<- FALSE

  result <- tryCatch(
    withCallingHandlers(
      expr,
      warning = function(w) {
        if (is.null(.current_warning_location)) .current_warning_location <<-
          .resolve_feedback_location(conditionMessage(w), calls = c(list(conditionCall(w)), sys.calls()))
        .current_warnings <<- c(.current_warnings, conditionMessage(w))}),
    error = function(e) {
      .show_error(e)
      stop(e)})

  if (length(.current_warnings) > 0) {
    .show_warning()
  } else if (show_success) .show_success(result, label, show_counts, variable_name)
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

.extract_variable_names <- function(source_msg, formula_variables = FALSE) {
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
  if (!formula_variables) object_vars <- object_vars[!.is_probably_data_name(object_vars)]
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

.data_name_warning <- function(msg, location = NULL) {
  recent_warnings <- .clean_msg(.get_recent_warnings())
  combined_msg <- paste(msg, recent_warnings, sep = "\n")

  object_names <- .extract_object_not_found_names(combined_msg)
  data_names <- object_names[.is_probably_data_name(object_names)]

  if (length(data_names) == 0) return("")

  data_names <- unique(data_names)

  .problem_panel("Data name problem", location,
    .name_problem_text(data_names, "There is no dataset loaded with this name: ",
      "There are no datasets loaded with these names: "),
    paste0("<p>Check <b>Environment &gt; Data</b>.</p>",
      .problem_reasons("The dataset name was typed incorrectly.",
        paste0("The dataset was not loaded yet. Go to the top of this R Script file, highlight and run the ",
          "&ldquo;Refresh data and packages&rdquo; code."))))}

.extract_model_names <- function(msg, location = NULL, calls = sys.calls()) {
  object_names <- .extract_object_not_found_names(msg)
  model_names <- object_names[grepl("^model[0-9]*$", object_names)]
  if (length(object_names) == 0) return(model_names)
  if (!is.null(location$text)) {
    source_calls <- tryCatch(as.list(parse(text = location$text)), error = function(e) list())
    calls <- c(calls, source_calls)}
  for (call in Filter(is.call, calls)) {
    name <- sub("^.*::", "", .call_name(call))
    if (!name %in% c("check_model", "check_heteroscedasticity", "check_collinearity",
        "parameters", "model_parameters", "tab_model")) next
    args <- as.list(call)[-1]
    if (length(args) == 0) next
    arg_names <- names(args)
    if (is.null(arg_names)) arg_names <- rep("", length(args))
    model_args <- which(arg_names == "" | arg_names %in% c("model", "x", "object"))
    if (name != "tab_model") model_args <- head(model_args, 1)
    for (i in model_args) {
      if (is.symbol(args[[i]])) model_names <- c(model_names,
        intersect(object_names, as.character(args[[i]])))}}
  unique(model_names)}

.model_name_warning <- function(msg, location = NULL, model_names = NULL) {
  recent_warnings <- .clean_msg(.get_recent_warnings())
  combined_msg <- paste(msg, recent_warnings, sep = "\n")

  if (is.null(model_names)) model_names <- .extract_model_names(combined_msg, location)

  if (length(model_names) == 0) return("")

  model_names <- unique(model_names)

  .problem_panel("Model name problem", location,
    .name_problem_text(model_names, "This model does not exist: ", "These models do not exist: "),
    .problem_reasons(
      "The model name was typed incorrectly. Compare it with the name used when creating the model.",
      "The code that creates the model was not highlighted and run."))}

.variable_name_warning <- function(msg, formula_variables = FALSE, location = NULL, model_names = character(0)) {
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
  variable_names <- .extract_variable_names(source_msg, formula_variables)
  if (!formula_variables) variable_names <- variable_names[!gsub("`", "", variable_names) %in% c("gs", "gss", "gsss")]
  variable_names <- variable_names[!grepl("^model[0-9]*$", gsub("`", "", variable_names))]
  variable_names <- variable_names[!gsub("`", "", variable_names) %in% model_names]

  if (length(variable_names) == 0) return("")

  raw_variable_names <- gsub("`", "", variable_names)

  .problem_panel("Variable name problem", location,
    .name_problem_text(raw_variable_names, "This variable does not exist: ", "These variables do not exist: "),
    .problem_reasons(
      paste0("There is a typo in the variable name. Do not type variable names manually. ",
        "Copy and paste the variable name."),
      paste0("If this is a recoded, computed, or dummy variable:",
        "<ol style='margin-top:6px'><li>The prior codes were not highlighted and run, ",
        "so this variable doesn't exist in the dataset yet.",
        "<li>Preparing the code in the R Script file doesn't mean it's in the dataset; it must be highighted and run first.</li>",
        "<li>The further analyses that use this variable will not work until this code is fixed.</li></ol>")))}

.incorrect_code_warning <- function(msg, location = NULL) {
  recent_warnings <- .clean_msg(.get_recent_warnings())
  combined_msg <- paste(msg, recent_warnings, sep = "\n")

has_incorrect_code_problem <- grepl(
  paste0(
    "could not find function|",
    "grouping factor must have exactly 2 levels|",
    'Incorrect value for argument "|',
    "There's a problem in this line:|",
    "Syntax error in argument|",
    "'arg' should be one of|",
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
    "unexpected INCOMPLETE_STRING|",
    "unexpected '\\]'|",
    "_R_USE_PIPEBIND_|",
    "pipe operator|RHS call of a pipe|",
    "incomplete final line|",
    "incomplete expression|",
    "no applicable method for 'select' applied to an object"),
  combined_msg)

  if (!has_incorrect_code_problem && !isTRUE(location$incorrect_assignment) &&
      !isTRUE(location$incorrect_pipe) && !isTRUE(location$incorrect_parenthesis)) return("")
  if (is.null(location)) location <- .resolve_feedback_location(combined_msg)
  function_name <- .extract_function_name(combined_msg)

  explanation <- if (grepl("grouping factor must have exactly 2 levels", combined_msg, fixed = TRUE)) {
    "The factor variable must be binary (have exactly two levels)."
  } else if (length(function_name) > 0 && nzchar(function_name)) {
    paste0("Function <code>", .feedback_escape(function_name), "</code> does not exist.")
  } else if (grepl("could not find function", combined_msg, fixed = TRUE)) {
    "The function does not exist."
  } else if (is.na(location$line)) "The code is incomplete. Code arguments are missing." else ""
  .problem_panel("Incorrect code problem", location, explanation,
    paste0(.problem_reasons(
      "Something was accidentally deleted from or added to the code.",
      "A comma, quotation mark, parenthesis, semicolon, colon, bracket, function name, argument name, value, or pipe is missing or incorrect."),
      "<p>Go back to the model code and compare this line.</p>"))}

.problem_sections <- function(msg, location = NULL, formula_variables = FALSE) {
  if (isTRUE(location$incorrect_pipe) || isTRUE(location$incorrect_parenthesis)) return(.incorrect_code_warning(msg, location))
  model_names <- .extract_model_names(paste(msg, .clean_msg(.get_recent_warnings()), sep = "\n"), location)
  sections <- paste0(
    if (!formula_variables && length(model_names) == 0) .data_name_warning(msg, location) else "",
    .model_name_warning(msg, location, model_names),
    .variable_name_warning(msg, formula_variables, location, model_names))
  paste0(sections, .incorrect_code_warning(msg, location))}

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
  raw_msg <- conditionMessage(e)
  location <- .resolve_feedback_location(raw_msg, calls = c(list(conditionCall(e)), sys.calls()))
  if (grepl("unexpected |incomplete expression", raw_msg) && !is.na(location$line)) {
    if (!is.null(.last_parse_feedback) && identical(location$document, .last_parse_feedback$document) &&
        identical(location$block, .last_parse_feedback$block)) return(invisible())
    .last_parse_feedback <<- location}
  msg <- .clean_msg(raw_msg)
  recent_warnings <- .clean_msg(.get_recent_warnings())
  formula_variables <- identical(conditionCall(e), quote(eval(predvars, data, env))) ||
    grepl("^Error in eval\\(predvars,\\s*data,\\s*env\\)", raw_msg)
  sections <- .problem_sections(msg, location, formula_variables)

  .show_viewer(paste0(
    .error_checklist,
    sections,
    if (!nzchar(sections)) paste0(
      "<hr><p><b>Error message:</b></p>",
      .feedback_code_box(paste0(msg, "\n\n", .feedback_escape(.feedback_location_text(location))))
    ) else "",
    if (nzchar(recent_warnings) && !nzchar(sections)) paste0(
      "<hr><p><b>Warning message:</b></p>",
      .feedback_code_box(recent_warnings)
    ) else ""))}

.show_warning <- function() {
  recent_warnings <- .clean_msg(.get_recent_warnings())
  if (!nzchar(recent_warnings)) return(invisible())

  location <- .current_warning_location
  if (is.null(location)) location <- .resolve_feedback_location(.get_recent_warnings())
  sections <- .problem_sections("", location)

  .show_viewer(paste0(
    .error_checklist,
    sections,
    if (!nzchar(sections)) paste0(
      "<hr><p><b>Warning message:</b></p>",
      .feedback_code_box(paste0(recent_warnings, "\n\n", .feedback_escape(.feedback_location_text(location))))
    ) else ""))}

.show_success <- function(result, label, show_counts = TRUE, variable_name = NULL) {
  if (length(.current_warnings) > 0) return(.show_warning())
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
  value_names[is.na(value_names)] <- "NA"
  names(tbl) <- value_names
  label_lookup <- character(0)

  if (!is.null(value_labels)) {
    label_lookup <- setNames(names(value_labels), as.character(unname(value_labels)))
    label_names <- names(label_lookup)
    missing_label_values <- label_names[!label_names %in% value_names]
    if (length(missing_label_values) > 0) {
      missing_tbl <- setNames(rep(0, length(missing_label_values)), missing_label_values)
      tbl <- c(tbl, missing_tbl)
      value_names <- names(tbl)
      label_order <- c(label_names[label_names %in% value_names], setdiff(value_names, label_names))
      tbl <- tbl[label_order]
      value_names <- names(tbl)
    }
  }

missing_row <- is.na(value_names) | value_names == "" | value_names == "NA"
value_label_text <- base::ifelse(value_names %in% names(label_lookup), label_lookup[value_names], "")
value_label_text[missing_row] <- "Missing"
valid_total <- sum(as.integer(tbl)[!missing_row])
valid_pct <- rep(NA_real_, length(tbl))
valid_pct[!missing_row] <- as.integer(tbl)[!missing_row] / valid_total * 100
valid_pct_text <- base::ifelse(missing_row, "", paste0(formatC(valid_pct, format = "f", digits = 1), "%"))

counts_df <- data.frame(Value = value_names, Label = value_label_text, Frequency = as.integer(tbl),
  valid.prc = valid_pct_text, check.names = FALSE)

  paste(capture.output(print(counts_df, row.names = FALSE)), collapse = "\n")
}, error = function(e) "(could not compute counts)")

if (has_inf) {
  location <- attr(result, ".recode_problem_location")
  if (is.null(location)) location <- .resolve_feedback_location(fragment = attr(result, ".recode_problem_line"))
  .show_viewer(paste0(.error_checklist,
    .problem_panel("Incorrect code problem", location,
      "The recoded variable contains invalid values (-Inf).", paste0(
    "<p>This error happens when the recoding rules are not written correctly.</p>",
    "<ol>",
    "<li>Check whether all quotation marks, semicolons, parentheses, and brackets are closed correctly.</li>",
    "<li>This code should be fixed because RStudio still creates the variable, but the variable will incorrectly show <code>-Inf</code> in your analysis.</li>",
    "</ol>"))))
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
      "<table style='border-collapse:collapse'>",
      variable_row,
      "<tr><td style='padding:4px 12px 4px 0'><b>Variable label:</b></td>",
      "<td>", lbl, "</td></tr>",
      count_row,
      "</table>",
      "<div style='margin-top:20px;padding:16px;background:#eff6ff;",
      "border-left:4px solid #2563eb;border-radius:4px'>",
      "<h3 style='color:#1d4ed8;margin:0 0 12px'>&#8505; Reminder</h3>",
      "<p>Successfully creating a variable does not guarantee it is correct.</p>",
      "<ul>",
      "<li>Make sure the original and new variable names are in their correct places.</li>",
      "<li>Compare your code with the model code.</li>",
      "<li>If it is incorrect, highlight and run the &ldquo;Refresh data and packages&rdquo; ",
      "code at the top of this R Script file. Then fix and rerun your code.",
      "<ul style='margin-top:6px'>",
      "<li>Refreshing loads fresh data. If you created other new variables in this session, ",
      "you will need to run those codes again in order.</li>",
      "</ul></li>",
      "</ul></div>"))}}

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

.course_error_handler <- function() {
  on.exit(.viewer_error_shown <<- FALSE, add = TRUE)
  if (.viewer_error_shown) {
    .viewer_error_shown <<- FALSE
    return(invisible())}

  .current_warnings <<- character(0)
  tryCatch(.show_error(simpleError(geterrmessage())),
    error = function(e) message("Error feedback failed: ", conditionMessage(e)))}

## install feedback once per session; reload replaces older callbacks ----
while ("variable_created_success_callback" %in% getTaskCallbackNames()) {
  removeTaskCallback("variable_created_success_callback")}
.ensure_viewer_feedback()
