# Troubleshooting Notes

I am using this file to record problems I faced while building the project and how I fixed them.

This is useful because cloud projects do not always work correctly on the first attempt, and I want to understand the issues instead of only copying the final solution.

## Issue 1 - Terraform was not recognised

When I first tried to run Terraform in PowerShell, I received an error saying:

```text
terraform is not recognized as the name of a cmdlet
Cause
Terraform was either not installed correctly or the executable was not added to the Windows PATH.
Fix
I downloaded the correct Windows AMD64 version of Terraform, added its folder to the Windows PATH, restarted VS Code and tested it using:
terraform -version

After this, Terraform worked correctly.
Issue 2 - Git was not recognised
When I tried to initialise the Git repository, PowerShell could not find the git command.
Fix
I installed Git for Windows, restarted VS Code and confirmed the installation using:
git --version

Issue 3 - GitHub authentication failed
My first GitHub push did not work because the authentication dialog was cancelled.
Fix
I configured Git Credential Manager and tried the push again:
git config --global credential.helper manager
git push -u origin main

GitHub then opened browser authentication and the push completed successfully.
Issue 4 - Terraform local files were staged in Git
The .terraform directory was initially included when I ran:
git add .

This directory contains local provider files and should not be committed to GitHub.
Fix
I created a root .gitignore file and excluded:
**/.terraform/*
*.tfstate
*.tfstate.*

I then removed the Terraform directory from Git tracking.
What I learned
These problems helped me understand:
- How PATH environment variables work
- Why Terraform provider files should not be committed
- How .gitignore protects local and sensitive files
- How GitHub authentication works
- Why checking git status before committing is important