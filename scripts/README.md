#### Installing required libraries

- pystache: 
  `pip install -r requirements.txt`

- [gcsfuse](https://github.com/GoogleCloudPlatform/gcsfuse/blob/master/docs/installing.md)

#### Usage

See also: https://github.com/GoogleCloudPlatform/gcsfuse/blob/master/docs/mounting.md

1. Login with application-default creds:
  ```
  gcloud auth application-default login
  ```

2. Mount Google bucket to local directory
  ```bash
  mkdir -p /tmp/mnt/
  gcsfuse --implicit-dirs data-public-monarchinitiative /tmp/mnt
  ```
  
3. If necessary, update the latest directory
```bash
export LATEST=$(ls /tmp/mnt/monarch/ | grep -E "^2[0-9]{5}" | tail -1)
gsutil cp -r gs://data-test.monarchinitiative.org/monarch/$LATEST/* gs://data-test.monarchinitiative.org/monarch/latest
```


4. Generating index.html
```bash
python3.8 -m venv venv
source venv/bin/activate
python3 ./scripts/directory_indexer.py -v --inject ./scripts/directory-index-template.html --directory /tmp/mnt --prefix https://data.monarchinitiative.org -x
```

5. Unmount
```
umount /tmp/mnt         # OS X
fusermount -u /tmp/mnt  # Linux
```
