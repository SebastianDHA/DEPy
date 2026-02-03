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
    python -m build

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
