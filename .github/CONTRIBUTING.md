# Contributing to arcenso

This outlines how to propose a change to arcenso.
For a detailed discussion on contributing to this and other tidyverse packages, please see the [development contributing guide](https://rstd.io/tidy-contrib) and our [code review principles](https://code-review.tidyverse.org/).


## Language / Idioma

This project is developed in Argentina, and we welcome contributions in both **English** and **Spanish**.

 - Issues: You are welcome to open new issues or comment on existing ones in either language.

 - Pull Requests: You can submit and discuss PRs in Spanish or English.

 - Code & Docs: While formal documentation and code comments are primarily in English to maintain global standards, do not let language be a barrier. Feel free to communicate in the language you feel most comfortable with, and we can work together on the final technical translation if needed.


Este proyecto se desarrolla en Argentina y aceptamos contribuciones tanto en **inglés** como en **español**.

 - Issues: Podés abrir nuevos hilos o comentar en los existentes en cualquiera de los dos idiomas.

 - Pull Requests: Podés enviar y discutir propuestas de cambio (PRs) en español o inglés.

 - Código y Docs: Aunque la documentación formal y los comentarios en el código se mantienen preferentemente en inglés por estándares globales, que el idioma no sea una barrera. Comunicate en el idioma que prefieras y, si es necesario, podemos trabajar juntos en la traducción técnica final.


## Bigger changes

If you want to make a bigger change, it's a good idea to first file an issue and make sure someone from the team agrees that it’s needed. 
If you’ve found a bug, please file an issue that illustrates the bug with a minimal 
[reprex](https://www.tidyverse.org/help/#reprex) (this will also help you write a unit test, if needed).
See our guide on [how to create a great issue](https://code-review.tidyverse.org/issues/) for more advice.

### Pull request process

*   Fork the package and clone onto your computer. If you haven't done this before, we recommend using `usethis::create_from_github("SoyAndrea/arcenso", fork = TRUE)`.

*   Install all development dependencies with `devtools::install_dev_deps()`, and then make sure the package passes R CMD check by running `devtools::check()`. 
    If R CMD check doesn't pass cleanly, it's a good idea to ask for help before continuing. 
*   Create a Git branch for your pull request (PR). We recommend using `usethis::pr_init("brief-description-of-change")`.

*   Make your changes, commit to git, and then create a PR by running `usethis::pr_push()`, and following the prompts in your browser.
    The title of your PR should briefly describe the change.
    The body of your PR should contain `Fixes #issue-number`.

*  For user-facing changes, add a bullet to the top of `NEWS.md` (i.e. just below the first header). Follow the style described in <https://style.tidyverse.org/news.html>.

### Code style

*  New code should follow the tidyverse [style guide](https://style.tidyverse.org). 
    You can use [Air](https://posit-dev.github.io/air/) to apply this style, but please don't restyle code that has nothing to do with your PR.  

*  We use [roxygen2](https://cran.r-project.org/package=roxygen2), with [Markdown syntax](https://cran.r-project.org/web/packages/roxygen2/vignettes/rd-formatting.html), for documentation.  

*  We use [testthat](https://cran.r-project.org/package=testthat) for unit tests. 
   Contributions with test cases included are easier to accept.  

## Code of Conduct

Please note that the arcenso project is released with a
[Contributor Code of Conduct](CODE_OF_CONDUCT.md). By contributing to this
project you agree to abide by its terms.
