# Templatepy Cursor Rules

This repository contains the shared `.cursor` rules for `templatepy` projects.

## Usage

To use these rules in your project, add this repository as a Git submodule. This will place the contents of this repository into a `.cursor` directory in your project.

### Add as a Submodule

From the root of your parent repository, run the following command:

```sh
git submodule add --force git@github.com:HuaMick/templatepy-cursor-rules.git .cursor
```

This command clones the rules into the `.cursor` folder. The `--force` option is used to overwrite the directory if it already exists but is not a submodule.

### Updating the Rules

To pull the latest changes into the submodule from your parent repository, you can run:

```sh
git submodule update --remote --merge
```