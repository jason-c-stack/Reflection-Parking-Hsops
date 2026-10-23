# Add this code to your GitHub repository

This folder contains research code and documentation. It does not require a website or GitHub Pages.

## Easiest option: GitHub Desktop

1. Extract the ZIP if you downloaded it. Open the resulting `reflection-parking-hsop` folder.
2. In GitHub Desktop, sign in, choose **File → Clone repository**, and select your existing repository. Choose a convenient local location.
3. In Finder, copy the entire `reflection-parking-hsop` folder into that local repository. Keeping it as a subfolder avoids replacing an existing README or other files. Do not copy the ZIP into the repository.
4. In GitHub Desktop, select the repository. Create a branch such as `add-parking-and-hsop-code` using **Current Branch → New Branch**.
5. Review the changed files. Use the commit summary `Add cleaned parking-function and HSOP research code`, then click **Commit to add-parking-and-hsop-code**.
6. Click **Publish branch** (or **Push origin** if the branch already exists).
7. Click **Create Pull Request**, review the changes on GitHub, and merge when ready. The code then appears in your repository's **Code** tab.

If you want the package at the repository root instead, copy its contents there and merge the README and ignore settings with any existing versions. Keep the `gap3`, `wolfram`, and `docs` directory names so relative paths continue to work.

GitHub's guides: [Manage branches](https://docs.github.com/en/desktop/making-changes-in-a-branch/managing-branches-in-github-desktop), [commit and review changes](https://docs.github.com/en/desktop/making-changes-in-a-branch/committing-and-reviewing-changes-to-your-project-in-github-desktop), [clone a repository](https://docs.github.com/en/desktop/adding-and-cloning-repositories/cloning-and-forking-repositories-from-github-desktop) and [add an existing local repository to Desktop](https://docs.github.com/en/desktop/adding-and-cloning-repositories/adding-a-repository-from-your-local-computer-to-github-desktop).

## Browser upload option

On your repository's **Code** tab, choose **Add file → Upload files**. Drag the extracted `reflection-parking-hsop` folder into the upload area. Review the file paths, choose **Create a new branch for this commit and start a pull request**, and complete the upload. Review and merge the pull request. Upload the extracted folder, rather than its ZIP, to make the source browsable.

GitHub's guide: [Adding a file to a repository](https://docs.github.com/en/repositories/working-with-files/managing-files/adding-a-file-to-a-repository).

## Terminal option for an existing repository

Replace `YOUR-USERNAME`, `YOUR-REPOSITORY`, and `/path/to/reflection-parking-hsop` below. If you already have a local clone, start with `cd` into it instead of cloning again.

```sh
git clone https://github.com/YOUR-USERNAME/YOUR-REPOSITORY.git
cd YOUR-REPOSITORY
git switch -c add-parking-and-hsop-code
cp -R "/path/to/reflection-parking-hsop" ./reflection-parking-hsop
git add reflection-parking-hsop
git diff --cached --stat
git commit -m "Add cleaned parking-function and HSOP research code"
git push -u origin add-parking-and-hsop-code
```

Open the repository on GitHub and use **Compare & pull request**. Review and merge it. No force push is needed. HTTPS authentication uses a supported sign-in method or a personal access token rather than your GitHub account password; [GitHub's authentication guide](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/about-authentication-to-github) explains the options.

## If you need a new repository

Create an empty repository on GitHub. For this method, leave the README, license, and `.gitignore` initialization options unchecked. In Terminal, enter the extracted package folder, then run:

```sh
git init -b main
git add .
git commit -m "Add parking-function and HSOP research code"
git remote add origin https://github.com/YOUR-USERNAME/YOUR-REPOSITORY.git
git push -u origin main
```

See [GitHub's import instructions](https://docs.github.com/en/migrations/importing-source-code/using-the-command-line-to-import-source-code/adding-locally-hosted-code-to-github).

## Before merging

Read `docs/VALIDATION.md` for checks actually run and remaining mathematical limitations. If the repository has a license, confirm it covers these files and any borrowed code. This cleanup does not choose a license or alter attribution.
