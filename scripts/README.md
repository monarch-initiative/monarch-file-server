#### Installing gscfuse
https://github.com/GoogleCloudPlatform/gcsfuse/blob/master/docs/installing.md

#### Mounting bucket to local fs
See also: https://github.com/GoogleCloudPlatform/gcsfuse/blob/master/docs/mounting.md

Mounting requires login with application-default creds
```
gcloud auth application-default login
```

```bash
mkdir /tmp/mnt/ || true
gcsfuse --implicit-dirs data-test.monarchinitiative.org /tmp/mnt
```

#### If necessary, update the latest directory
```bash
export LATEST=$(ls /tmp/mnt/monarch/ | grep -E "^2[0-9]{5}" | tail -1)
gsutil cp -r gs://data-test.monarchinitiative.org/monarch/$LATEST/* gs://data-test.monarchinitiative.org/monarch/latest
```


#### Generating index.html
```bash
python3.8 -m venv venv
source venv/bin/activate
python3 ./scripts/directory_indexer.py -v --inject ./scripts/directory-index-template.html --directory /tmp/mnt --prefix https://data-test.monarchinitiative.org -x
```

#### Unmount
```
umount /tmp/mnt         # OS X
fusermount -u /tmp/mnt  # Linux
```
