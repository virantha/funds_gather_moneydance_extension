#!/usr/bin/env zsh -i

# Auto-generated by Voodoo
# First-time script for project setup (DELETE ME AFTER RUNNING!)

DOCS_DIR=~/dev/githubdocs

print Setting up your virtualenv

rmvirtualenv funds_gather_moneydance_extension
if [ $? -ne 0 ]; then
    print Removing old virtualenv failed
    exit -1
fi
mkvirtualenv funds_gather_moneydance_extension
if [ $? -ne 0 ]; then
    print Making funds_gather_moneydance_extension Virtual env failed
    exit -1
fi

workon funds_gather_moneydance_extension
if [ $? -ne 0 ]; then
    print Could not switch to funds_gather_moneydance_extension
    exit -1
fi
print Working in virtualenv funds_gather_moneydance_extension


# Set up the pip packages
pip install pytest mock pytest-cov python-coveralls coverage sphinx tox restview schema docopt
#pip install sphinx restview
echo "cd ~/dev/funds_gather_moneydance_extension" >> ~/dev/envs/funds_gather_moneydance_extension/bin/postactivate

# Start python develop
python setup.py develop

# Initialize the git repo
github_remote='git@github.com:virantha/funds_gather_moneydance_extension.git'
git init
git remote add origin $github_remote
git add .
git commit -am "Setting up new project funds_gather_moneydance_extension"

# Prompt if we want to push to remote git
read -q "REPLY?Create remote repository at $github_remote [y/N]?"
if [[  $REPLY == y ]]; then
    curl --data '{"name":"funds_gather_moneydance_extension", "description":""}' --user "virantha" https://api.github.com/user/repos
fi

read -q "REPLY?Push to remote repository $github_remote [y/N]?"
if [[  $REPLY == y ]]; then
    git push -u origin master
fi

print
# Create the docs repository
current_dir=`pwd`
read -q "REPLY?Create and push docs to $github_remote [y/N]?"
if [[  $REPLY == y ]]; then
    # Go to the docs build dir, and check out our repo
    cd $DOCS_DIR
    git clone https://github.com/virantha/funds_gather_moneydance_extension.git
    cd funds_gather_moneydance_extension
    git checkout --orphan gh-pages
    git rm -rf .

    cd $current_dir/docs
    pip install sphinx
    make html
    cd $DOCS_DIR
    cd funds_gather_moneydance_extension
    touch .nojekyll
    git add .
    git commit -m "docs"
    git push origin gh-pages

fi