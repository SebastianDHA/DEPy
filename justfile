# justfile for DEPy

# -------------------------------------------------
#  1⃣ Create conda environment from file
# -------------------------------------------------
env:
    # Creates the conda environment from environment.yml
    conda env create -f environment.yml -n depy

# -------------------------------------------------
#  2⃣ Install editable package
# -------------------------------------------------
install:
    pip install -e .

# -------------------------------------------------
#  3⃣ Run tests on editable install
# -------------------------------------------------
tests:
    pytest -v

# -------------------------------------------------
#  4⃣ Build wheel and test it
# -------------------------------------------------
wheel:
    pip install build toml
    VERSION=$(python -c "import toml; print(toml.load('pyproject.toml')['project']['version'])")
    python -m build
    pip install dist/summarizedpy-${VERSION}-py3-none-any.whl
    pytest -v

# -------------------------------------------------
#  5⃣ Build MkDocs site
# -------------------------------------------------
docs:
    mkdocs build

# -------------------------------------------------
#  6⃣ Deploy docs to GitHub Pages
# -------------------------------------------------
deploy:
    mkdocs gh-deploy --clean

# -------------------------------------------------
#  7⃣ Clean dist
# -------------------------------------------------
clean:
    rm -rf dist
