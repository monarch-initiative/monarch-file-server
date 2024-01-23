pipeline {
    agent { label 'monarch-agent-small' }
        environment {
        HOME = "${env.WORKSPACE}"
        RELEASE = sh(script: "echo `date +%Y-%m-%d`", returnStdout: true).trim()
        PATH = "/opt/poetry/bin:${env.PATH}"
    }
    stages {
        stage('index') {
            steps {
                sh '''
                    echo "Current directory:"
                    pwd
                    echo "Current dir contents:"
                    ls -al
                    
                    # cd $HOME
                    mkdir data-public
                    gcsfuse --implicit-dirs data-public-monarchinitiative data-public
                    ls -l data-public

                    # git clone https://github.com/monarch-initiative/monarch-file-server.git
                    pip install -r scripts/requirements.txt
                    python3 scripts/directory_indexer.py --inject scripts/directory-index-template.html --directory data-public --prefix https://data.monarchinitiative.org -x
                '''
            }
        }
    }
}
