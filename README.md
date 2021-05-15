

## CopernicusDEM

<br>

Copernicus Digital Elevation Model datasets (DEM) of 90 and 30 meters resolution using the 'awscli' command line tool. The Copernicus (DEM) is included in the Registry of Open Data on AWS

<br>

**System Requirements**:

This R package uses the command line **awscli** internally, which has to be installed first in the Operating System. 

<br>

On **Ubuntu** this can be done using:

```R
sudo apt install -y awscli

```

<br>

On **Macintosh** use,

```R
brew install awscli

```

<br>

and on **Windows 10** (tested) open the command line (cmd) and type,

```R
msiexec.exe /i https://awscli.amazonaws.com/AWSCLIV2.msi

```

which will open a new window ('AWS command line interface v2 Setup'), then click twice on 'next' and then 'install' and 'allow the device to make changes' and once another window pop-ups click 'finish'

<br>

Then verify the installation using,

```R
aws --version

```

<br>

and proceed to **configure aws** using either 

```R
aws configure

```

or

```R
export AWS_ACCESS_KEY_ID=xxxxxxxxx
export AWS_SECRET_ACCESS_KEY=xxxxxxxxx
export AWS_DEFAULT_REGION=eu-central-1

```

<br>

To check that **awscli** was installed and configured successfully run the following line in the command line. It returns the first 10 files of the 90 meter DEM product (for verification purposes),

```R
aws s3 ls s3://copernicus-dem-90m | head -n 10

```

<br>

To install the package from CRAN use, 

```R
install.packages("CopernicusDEM")

```
<br>

and to download the latest version of the package from Github,

```R
remotes::install_github('mlampros/CopernicusDEM')

```

<br>


### Credits:

* "produced using Copernicus WorldDEMTM-90 DLR e.V. 2010-2014 and Airbus Defence and Space GmbH 2014-2018 provided under COPERNICUS by the European Union and ESA; all rights reserved"

<br>