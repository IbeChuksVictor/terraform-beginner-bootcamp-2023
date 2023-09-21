# Terraform Beginner Bootcamp 2023

## Semactic Versioning :mage:

This project is going to utilize semantic versioning for its tagging.
[semver.org](https://semver.org)

The general format:

**MAJOR.MINOR.PATCH**, e.g `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

## Install the Terraform CLI

### Considerations with Terraform CLI changes

The Terraform CLI installation changed due to gpg keyring change. So refer to the lastest install CLI instruction via Terraform Documentaion [here](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) and change the scripting for the installation.

### Consideration for Linux Environment Distribution

This project is build against the Ubuntu Linux distribution.
Consider checking your Linux distribution and change accordingly to your distribution needs.<br>
[How to check your Linux Distribution](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)<br>
Example:
```zsh
$ cat /etc/os-release

PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```


### Refactoring into Bash Script

Fixing the gpg deprecation issue proved that the steps involved were a considerable amount of more code in the `.gitpod.yml` file. So a [bash script](./bin/install_terraform_cli.sh) was created to install the Terraform CLI.

- This will keep the [.gitpod.yml](./.gitpod.yml) task file tidy. Reason is stated [here](https://www.gitpod.io/docs/configure/workspaces/tasks).
- This will allow for easier debugging.
- Easier portability to other projects that will need to install the Terraform CLI.

#### Shebang Considerations

Make sure to add the Shebang(`#!`) character sequence to the first line of the bash script. It points the bash script program to the location of the program's interpreter.<br>
Use:
```sh
#!/usr/bin/env bash
```
Instead of:
```sh
#!/bin/bash
``` 
- For portability with different Linux OS distribution environment
- Will search the appropriate env path to the interpreter.<br>

[Shebang](https://en.wikipedia.org/wiki/Shebang_(Unix))

#### Execution Considerations
When executing the bash script, use the "`./`" short-hand connotation to execute the script.<br>
E.g:
```zsh
$ ./bin/install_terraform_cli.sh
```
If using the script in the `.gitpod.yml` task file, point the script to a program to execute it.<br>
E.g:
```yaml
tasks:
  - name: terraform
    init: |
      source ./bin/install_terraform_cli.sh
```


#### Linux File Permission Considerations
To make bash script executable consider giving user file executable permissions.<br>
E.g:
```zsh
$ chmod u+x ./bin/install_terraform_cli.sh
```
or<br>
```zsh
$ chmod 744 ./bin/install_terraform_cli.sh
```
[Linux File Permissions](https://en.wikipedia.org/wiki/Chmod)


### GitHub Lifecycle (`before`, `init`, `command`)

Becareful when using `init` in the `.gitpod.yml` file because it will not rerun when the gitpod workspace is relaunched.<br>
Check [here](https://www.gitpod.io/docs/configure/workspaces/tasks) for insights.

### Working with Env Vars

#### env command

List Out all Environment Variables (Env Vars) using the `env` command like thus:

```zsh
$ env

PYENV_HOOK_PATH=/home/gitpod/.gp_pyenv.d
PIPENV_VENV_IN_PROJECT=true
GP_PREVIEW_BROWSER=/ide/bin/remote-cli/gitpod-code --preview
PYENV_SHELL=bash
rvm_prefix=/home/gitpod
SUPERVISOR_ADDR=localhost:22999
HOSTNAME=ibechuksvic-terraformbe-3gn1ocppzgh
GITPOD_REPO_ROOT=/workspace/terraform-beginner-bootcamp-2023
JAVA_HOME=/home/gitpod/.sdkman/candidates/java/current
...
```

Filter specific env vars using the `grep` command passed through the pipe symbol (`|`).<br>
E.g:
```zsh
$ env | grep terraform

HOSTNAME=ibechuksvic-terraformbe-3gn1ocppzgh
GITPOD_REPO_ROOT=/workspace/terraform-beginner-bootcamp-2023
PWD=/workspace/terraform-beginner-bootcamp-2023
THEIA_WORKSPACE_ROOT=/workspace/terraform-beginner-bootcamp-2023
GITPOD_WORKSPACE_ID=ibechuksvic-terraformbe-3gn1ocppzgh
GITPOD_WORKSPACE_CONTEXT_URL=https://github.com/IbeChuksVictor/terraform-beginner-bootcamp-2023/tree/5-project-root-env-var
GITPOD_REPO_ROOTS=/workspace/terraform-beginner-bootcamp-2023
...
```

#### Setting and Unsetting Env Vars

In the terminal, en vars can be set using this command:
```zsh
$ export HELLO="world"
```
They can be unset usinf this command:
```zsh
$ unset HELLO="world"
```
They can also be set temporarily by just running the command inline like this:
```zsh
$ HELLO="world" ./bin/print_message
```

Within bash script, it can be set without writing export.<br>
E.g:
```sh
#!/usr/bin/env bash

HELLO="world"

echo $HELLO
```
#### Printing Env Vars

Env Vars can be printed using the echo command on the terminal.<br>
E.g:
```zsh
$ echo $HELLO
```

#### Scope of Env Vars
Env Vars are limited to a specific session of bash terminals. They seize to exist when the session ends. To set them to persist across all future bash terminal sessions, env vars need to be updated in the bash profile file. e.g `.bashrc` or `.bash_profile` files.

#### Persisting Env Vars in Gitpod

Env Vars can be persisted into the gitpod env by storing them in the gitpod secrets storage by running this command:
```zsh
$ gp env HELLO="world"
```
All future workspaces lauched will set the env vars for all bash terminals opened in those workspaces.

Env Vars can also be set in the `.gitpod.yml` file of the Gitpod launch template. This is usually used to store non-sensitive env vars.