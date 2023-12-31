#!/bin/sh
set -e

echo "Activating feature 'openfasttrace'"

# The 'install.sh' entrypoint script is always executed as the root user.
#
# These following environment variables are passed in by the dev container CLI.
# These may be useful in instances where the context of the final 
# remoteUser or containerUser is useful.
# For more details, see https://containers.dev/implementors/features#user-env-var
echo "The effective dev container remoteUser is '$_REMOTE_USER'"
echo "The effective dev container remoteUser's home directory is '$_REMOTE_USER_HOME'"

echo "The effective dev container containerUser is '$_CONTAINER_USER'"
echo "The effective dev container containerUser's home directory is '$_CONTAINER_USER_HOME'"

DEBIAN_FRONTEND=noninteractive apt-get update && apt-get --yes install default-jre-headless wget
cd /usr/share/java && wget https://github.com/itsallcode/openfasttrace/releases/download/3.7.0/openfasttrace-3.7.0.jar

cat > /usr/local/bin/openfasttrace \
<< 'EOF'
#!/bin/sh
java -jar /usr/share/java/openfasttrace-3.7.0.jar $@
EOF

chmod +x /usr/local/bin/openfasttrace
cp /usr/local/bin/openfasttrace /usr/local/bin/oft