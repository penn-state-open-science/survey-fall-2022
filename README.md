# survey-fall-2022

Materials related to a survey conducted in Spring 2023 by a group of Penn State researchers. We'd initially hoped to launch the survey in Fall 2022.

These files generate a web site that can be viewed at: <https://penn-state-open-science.github.io/survey-fall-2022/>.

## Installation

- Clone the repo from GitHub.
- To render the full protocol, execute `bookdown::render_book('protocol')` from the root directory. An HTML protocol will be written to `docs/`.

### Update data and site

- If you have access to the Google Sheet, you can update the data and the visualizations in two commands at the R console:
    - `source "R/functions.R"`
    - `update_report()`
- At the moment, only the PIs on the survey project have access to the Google Sheet.

### GitHub authentication

- run `usethis::create_github_token()` to generate an access token on GitHub. Copy and save the token in a safe location, e.g., a password manager.
- run `gitcreds::gitcreds_set()` to save the token.

## Contents

- `docs/`: output directory for rendered protocol for use by GitHub pages.
- `protocol/`: source files for protocol.
- `irb/`: files related to the IRB review for this project.
