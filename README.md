# survey-fall-2022

Materials related to a survey conducted in Fall 2022.

## Installation

- Clone the repo from GitHub.
- ~~We use `renv` to try to make the code more readily reproducible. So, there is some time at the beginning where you will be asked to approve the installation of a number of required packages. In some cases (e.g., Penn State's RStudio Server instance), the installation process timed out several times because a number of packages had to be compiled from source. Running `renv::restore()` again until the full package installation list has been processed seems to work.~~ As of 2022-11-04, this is not quite working. So, it is disabled.

### GitHub authentication

- run `usethis::create_github_token()` to generate an access token on GitHub. Copy and save the token in a safe location, e.g., a password manager.
- run `gitcreds::gitcreds_set()` to save the token.

## Survey

- We drafted the survey using Google Forms: <https://docs.google.com/forms/d/13wH71-Es_HkeR_pVCdyelX0R3mIh4hDpXtsWfJtMSOY/edit>

## IRB protocol

- Documents related to the protocol may be found in [irb/](irb).
- The protocol name and number are as follows:
    - STUDY00021455: Open science at Penn State
<<<<<<< HEAD
- [Action log](irb/README.md)
- [Submissions](irb/submissions)
    - [202211](irb/submissions/2021111)
- [Templates](irb/templates)
    - [HRP-591](https://irb.psu.edu/IRB/sd/Doc/0/RI1D4A1VTUS4R30B6EGVR56JBC/HRP-591%20-%20Protocol%20for%20Human%20Subject%20Research.docx) protocol template.
    - [HRP-509](https://irb.psu.edu/IRB/sd/Doc/0/5QOLUGBK59AK1F170VP48451AC/HRP-509%20-%20Study%20Team%20Member%20Qualification%20Template.docx) Study Member Qualification Template.
    - [Consent templates](https://irb.psu.edu/IRB/sd/Rooms/DisplayPages/LayoutInitial?tab2=294B1E5FDD6A8142A2AF57F5F7F197BF&container=com.webridge.entity.Entity%5BOID%5BFB78CE9F10C2AF4B91A7880D62D229EE%5D%5D)
    - [Verbal/implied or written consent template](https://irb.psu.edu/IRB/sd/Doc/0/AF4KKKGDEMFKLAN164QN48GNFE/HRP-580%20-%20HRPP%20Consent%20Form%20Template.docx)