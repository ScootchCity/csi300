![Databases](https://i.imgur.com/D2Sfd70.jpeg)

-----------------

# Databases Course Repository

This repo belongs to [Game Guild Databases Course](https://gameguild.gg/p/databases/). If you use this repo, consider yourself under the [Academic Honesty](https://gameguild.gg/academic-honesty). Read both throughly. If you have any questions, bug fix, or improvement proposal, raise an issue. Especially if you have found someone misusing the repo, we will report and file a DMCA takedown. Read the [LICENSE](./LICENSE.md) if you are in doubt.

**WARNING: IF YOU ARE A STUDENT IN THE CLASS, DO NOT DIRECTLY FORK THIS REPO. DO NOT PUSH PROJECT SOLUTIONS PUBLICLY. THIS IS AN ACADEMIC INTEGRITY VIOLATION AND CAN LEAD TO GETTING YOUR DEGREE REVOKED, EVEN AFTER YOU GRADUATE.**

**WARNING: IF YOU ARE A STUDENT OUTSIDE CHAMPLAIN, DO NOT MAKE YOUR SOLUTION PUBLICLY AVAILABLE, AND DO SUBMIT YOUR OWN WORK. OTHERWISE, YOU WILL BE BANNED FROM GAMEGUILD AND REPORTED ON GITHUB** Thank you for creating a fair learning environment.

You are allowed to fork this repo in cases you want to contribute to it, or if you are an instructor wanting to use it for your own class.

## Cloning this Repository

The following instructions are adapted from the GitHub documentation on [duplicating a repository](https://docs.github.com/en/github/creating-cloning-and-archiving-repositories/creating-a-repository-on-github/duplicating-a-repository). The procedure below walks you through creating a private network repository that you can use for development.

Alternativelly, you may want to follow this process on any **GOOD** GIT-GUI tools. Such as [git-fork](https://git-fork.com/), [SmartGit](https://www.smartgit.dev/download/), or [GitKraken](https://www.gitkraken.com/).

1. [Create a new repository](https://github.com/new) under your account. Pick a name (e.g. `databases-private`) and select **Private** for the repository visibility level.
2. On your development machine, create a bare clone of the public databases repository:
    - Remember to select short folder path without spaces and special characters:
        - Windows: near your `C` Drive. Ex.: `C:\src\databases`;
        - Linux: near `home` folder. Ex.: `/home/username/src/databases`;
        - MacOS: near `Users` folder. Ex.: `/Users/username/src/databases`;
    ```console
    $ git clone --bare https://github.com/gameguild-gg/databases.git databases-public
    ```
3. Next, [mirror](https://git-scm.com/docs/git-push#Documentation/git-push.txt---mirror) the public databases repository to your own private databases repository. Suppose your GitHub name is `student` and your repository name is `databases-private`. The procedure for mirroring the repository is then:
   ```console
   $ cd databases-public
   
   # If you pull / push over HTTPS
   $ git push https://github.com/student/databases-private.git main

   # If you pull / push over SSH
   $ git push git@github.com:student/databases-private.git main
   ```
   This copies everything in the public databases repository to your own private repository. You can now delete your local clone of the public repository:
   ```console
   $ cd ..
   $ rm -rf databases-public
   ```
4. Clone your private repository to your development machine:
   ```console
   # If you pull / push over HTTPS
   $ git clone https://github.com/student/databases-private.git

   # If you pull / push over SSH
   $ git clone git@github.com:student/databases-private.git
   ```
5. Add the public databases repository as a second remote. This allows you to retrieve changes from the gameguild-gg repository and merge them with your solution throughout the semester:
   ```console
   $ git remote add public https://github.com/gameguild-gg/databases.git
   ```
   You can verify that the remote was added with the following command:
   ```console
   $ git remote -v
   origin	https://github.com/student/databases-private.git (fetch)
   origin	https://github.com/student/databases-private.git (push)
   public	https://github.com/gameguild-gg/databases.git (fetch)
   public	https://github.com/gameguild-gg/databases.git (push)
   ```
6. You can now pull in changes from the public databases repository as needed with:
   ```console
   $ git pull public main
   ```
7. **Enable GitHub Actions** from the project settings of your private repository on github.com;
   ```
   Settings > Actions > General > Actions permissions > Allow All actions and reusable workflows
   Settings > Actions > General > Workflow permissions > Read and write permissions
   ```
8. Add your itstructor username as a collaborator to your private repository so they can view your code and help you debug issues.
  ```
  Settings > Collaborators and teams > Manage access > Add people
  ```

## IDE Setup

You may want to use any IDE of your choice, but I will be using JetBrains IDEs for this course, so it will be easier to follow along if you do the same. VS Code is also a good choice, but I will not be providing specific instructions for it, besides that, the contextual autocomplete and other features in JetBrains IDEs are generally better.

1. (Optional) [Apply for Jetbrains Student License](https://www.jetbrains.com/academy/student-pack/). A student license gives you free access to all JetBrains IDEs;
2. Install [Jetbrains Toolbox](https://www.jetbrains.com/toolbox-app/);
3. Login to Jetbrains Toolbox using your student account;
    - Once you log in, you will have access to all JetBrains IDEs for free as long as you are a student.
4. Install the following tools via Jetbrains Toolbox, they are free for students and non-commercial use
    - [DataGrip](https://www.jetbrains.com/datagrip/). This will be extensively used for writing and testing SQL queries.
    - [WebStorm](https://www.jetbrains.com/webstorm/). This is mostly used for assignments involving JavaScript/TypeScript and Node.js.

::: warning "Disable AI Assistance"

Please disable AI assistance features (like GitHub Copilot, ChatGPT plugins, etc.) in any IDE you use for this course. Relying on AI tools can hinder your learning process and may lead to academic integrity issues. Read more about our [Academic Honesty](https://gameguild.gg/academic-honesty/).

On JetBrains IDEs, you can disable:

- AI assistance by going to `Settings/Preferences` > `Plugins` and disabling any AI-related plugins, such as
    - `GitHub Copilot`,
    - `Trae AI`,
    - or any other similar plugins you may have installed.
- In WebStorm, you can also disable AI code completion by going to `Settings/Preferences` > `Editor` > `General` > `Inline Completion` and unchecking the option for AI-based suggestions: such as
    - `Enable local Full Line completion Sugestions`,
    - `Enable automatic completion on typing`
    - `Enable multi-line suggestions`.

:::

## Repository Structure

```
databases/
├── README.md                # This file
├── syllabus.md              # Course syllabus
├── LICENSE.md               # License information
├── run-tests.sh             # Run verification for any assignment
├── .github/workflows/       # GitHub Actions (do not modify)
├── artifacts/               # CI/CD generated reports
└── assignment-XX/           # Assignment folders
    ├── README.md            # Assignment instructions
    ├── docker-compose.yml   # Database container setup
    ├── verify.sh            # Verification/grading script
    ├── exercises/           # Exercise markdown files
    ├── sql/                 # Student submission folder
    ├── base/                # (Optional) Pre-built schema
    ├── data/                # (Optional) Sample data files
    └── drizzle/             # (Optional) ORM exercises
```

### Assignment Folders

- Each assignment is in its own folder named `assignment-XX`
- Each assignment folder contains:
    - `README.md`: Instructions for the assignment
    - `docker-compose.yml`: Docker Compose file for the database environment
    - `verify.sh`: Verification script for automated grading
    - `exercises/`: Markdown files with exercise instructions
    - `sql/`: Directory for student SQL submissions

### Running Tests

Use the `run-tests.sh` script to verify any assignment:

```bash
./run-tests.sh assignment-01
./run-tests.sh assignment-02
# etc.
```

## Testing Assignments

### Quick Start (Recommended)

Test your assignment locally before submitting:

```bash
# Start the database
docker-compose up -d

# Test a specific assignment (e.g., assignment 2)
./test.sh 2

# Or test all assignments
./test.sh all
```

**Expected Output:**
```
========================================
  Assignment X - Verification
========================================
...
Total Points: 100 / 100
Grade: A
========================================
```

### Advanced Testing

For detailed testing options and troubleshooting, see **[TESTING.md](TESTING.md)** which includes:
- Direct testing with `./test.sh` (fastest)
- Manual testing with environment variables
- GitHub Actions simulation with `act`
- Debugging tips and common issues
- Quick reference card

### Automated Testing on GitHub

- Each assignment includes automated tests that run on GitHub Actions when you push
- Check the "Actions" tab on GitHub to see test results
- Tests verify:
  - SQL syntax correctness
  - Schema structure
  - Data integrity
  - Idempotency (can run multiple times)
  - Query accuracy

## Node.js Setup Instructions

- Install [`node.js`](https://nodejs.org/en/download/) LTS version on your machine. 
- Make sure it is properly installed by running the following commands in your terminal/command prompt:

``` bash
node -v
npm -v
```

::: tip "docker as node environment"

You may also use Docker as your Node.js environment if you prefer not to install Node.js directly on your machine. Each assignment includes a `docker-compose.yml` file that sets up the required Node.js environment for you.

:::
