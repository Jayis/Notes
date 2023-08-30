sudo adduser $1

sudo usermod -aG docker $1

sudo usermod -aG sudo $1

echo "listing groups for $1..."
groups $1
echo

echo "if the new user still does not have the privileges,"
echo "try \"sudo newgrp sudo\" and \"newgrp docker\""