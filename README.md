### Configuration
```
bundle config set --local path _gems
bundle install
```
### Preview the website
```
bundle exec jekyll serve
```

### Basic usage:
1) To add new project. Go in the _project_ folder. Copy one existing file and modify it.
2) To add publication: Open the file in _bibliography_/references.bib and add a new entry.

### Upload to your server:
```
./_tools/ftp_upload.sh
```
