# survey-fall-2022

Materials related to a survey conducted in Fall 2022 by a group of Penn State researchers.

## Installation

- Clone the repo from GitHub.
- To render the full protocol, execute `bookdown::render_book('protocol')` from the root directory. An HTML protocol will be written to `docs/`.

### GitHub authentication

- run `usethis::create_github_token()` to generate an access token on GitHub. Copy and save the token in a safe location, e.g., a password manager.
- run `gitcreds::gitcreds_set()` to save the token.

## Contents

- `docs/`: output directory for rendered protocol for use by GitHub pages.
- `protocol/`: source files for protocol.
- `irb/`: files related to the IRB review for this project.
