# Specify a base image
# FROM alpine -> Does not have node. Error: "/bin/sh: npm: not found."" 
# Fix
FROM node:alpine

# Add a folder where the app will be executed and where the files will be copied
WORKDIR /usr/app

# Fixes "npm WARN saveError ENOENT: no such file or directory, open '/package.json'"
# COPY ./ ./
# Don't want this file to be copied each time a change is made in e.g. the index.js file
# Is nice to segment the COPY operations to make sure you are copy the bare
# minimum for each successive step.
COPY ./package.json ./
# Install some dependencies
RUN npm install
# Copying the rest of the files to avoid invalidating the cache of the COPY 
# command each time a files from another part of the project is changed.
COPY ./ ./

# Default command
CMD ["npm", "start"]