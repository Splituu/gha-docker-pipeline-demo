# Universities API Docker Project
This project demonstrates a simple Python application that fetches data from the public Hipolabs Universities API 
and provides filtering capabilities. The project is containerized using Docker and includes GitHub Actions workflows for building, testing, and releasing Docker images.

## Features
- Fetches university data by country from the public API.
- Provides filtering by name, country, or other attributes.
- Containerized with Docker.
- Automated build, test, and release workflows using GitHub Actions.
- Weekly automated dependency updates via Dependabot for:
  - Docker images
  - Python dependencies (*requirements.txt*)
  - GitHub Actions workflows

 ## Project Structure
 ```bash
.
├── src/
│   └── main.py          # Main application code
├── tests/
│   └── test_main.py     # Pytest tests
├── Makefile             # Commands for build, run-local, push
├── version.txt          # Version of the Docker image
├── requirements.txt     # Python dependencies
├── .github/workflows/   # GitHub Actions workflows
│   ├── release.yml
│   └── test.yml
```

## Makefile Commands
- Build the Docker image
```bash
make build
```
Builds the image with tags based on the git SHA and *version.txt*.  
<br>
- Run the container locally
```bash
make run-local
```
Runs the Docker container locally and generates test reports in *junit/report.xml*.  
<br>
- Push the Docker image
```bash
make push
```
Pushes the image to the GitHub Container Registry with SHA and version tags.  
<br>
- Release (build + push)
```bash
make release
```

## Versioning
- The image version is defined in *version.txt* (e.g., 1.0.1).
- Images are tagged with both the version and the short git SHA for reproducibility.

## GitHub Actions Workflows
- **Release workflow (*release.yml*)** <br>
  Triggered on merges to the main branch. Builds and pushes the Docker image to the registry.
- **Test workflow (*test.yml*)** <br>
  Triggered after the release workflow completes. Pulls the image, runs tests inside the container, and uploads test reports as artifacts.

## Dependabot
- Automatically checks for updates weekly for:
    - Python dependencies (*requirements.txt*)
    - Docker base images
    - GitHub Actions workflows

## Usage
1. Clone the repository:
```bash
git clone <repo-url>
cd <repo-name>
```
2. Build and run locally:
```bash
make build
make run-local
```
3. Check test reports:
- Reports will be generated in *junit/report.xml*.
4. Push to registry:
```bash
make push
```
<br>
Made with ❤️ by Bartosz Pękala – DevOps enthusiast.
