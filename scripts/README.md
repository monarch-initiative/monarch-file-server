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

#### Generating index.html
```bash
python3.8 -m venv venv
source venv/bin/activate
```

#### Unmount
```
umount /tmp/mnt         # OS X
fusermount -u /tmp/mnt  # Linux
```
