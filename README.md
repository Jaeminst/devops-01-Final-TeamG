# devops-01-Final-TeamG-scenario1
## 화물 용달 예약/조회 서비스

소비자가 예약을 하고 조회할 수 있도록 기본적인 3tier Architechure로 dev환경을 구성함.

![스크린샷, 2022-06-07 10-16-37](https://user-images.githubusercontent.com/99110424/172275305-7ace9a51-6576-4afd-af42-05bde8517a5c.png)



`<Animated demo 첨부예정>`

## Contents
1. [Requirements](#requirements)
   * [Host setup](#host-setup)
   * [Terraform get started](#terraform-get-started)
     * [macOS](#macos)
     * [Windows](#windows)
     * [Ubuntu](#ubuntu)
1. [Usage](#usage)
   * [Inital setup](#inital-setup)
     * [S3 backend](#store-remote-state-on-s3-backend)
     * [Terraform apply](#terraform-apply)
     * [AWS credentials](#aws-credentials)
   * [Cleanup](#cleanup)
1. [Configuration](#configuration)
   * [Secret vars file manually](#secret-vars-file-manually)
   * [Secret vars file automatically](#secret-vars-file-automatically)
   * [What is inside the "tfvars"](#what-is-inside-the-tfvars)
1. [Additional notes](#additional-notes)
   * [How to unlock the state file](#how-to-unlock-the-state-file)
   * [Resource targetting for modifycation](#resource-targetting-for-modifycation)
   * [Apply complete outputs example](#apply-complete-outputs-example)
1. [Going further](#going-further)
   * [Plugins and integrations](#plugins-and-integrations)
   * [elk stack](#elk-stack)


## Requirements

### Host setup

> **Warning**  
> AWS Machine image by **Ubuntu 20.04** or oldwer recommended to use

#### Reservation client
* [nodejs][nodejs-install] version **14.x** or newer

#### Reservation API server
* [nodejs][nodejs-install] version **14.x** or newer

#### Notification API server
* [nodejs][nodejs-install] version **14.x** or newer

#### Docker-ELK

* [Docker Engine][docker-install] version **18.06.0** or newer
* [Docker Compose][compose-install] version **1.26.0** or newer (including [Compose V2][compose-v2])
* 1.5 GB of RAM

> **Note**  
> Especially on Linux, make sure your user has the [required permissions][linux-postinstall] to interact with the Docker
> daemon.

By default, the stack exposes the following ports:

* 5044: Logstash Beats input
* 5000: Logstash TCP input
* 9600: Logstash monitoring API
* 9200: Elasticsearch HTTP
* 9300: Elasticsearch TCP transport
* 5601: Kibana

Based on the official Docker images from Elastic:

* [Elasticsearch](https://github.com/elastic/elasticsearch/tree/master/distribution/docker)
* [Logstash](https://github.com/elastic/logstash/tree/master/docker)
* [Kibana](https://github.com/elastic/kibana/tree/master/src/dev/build/tasks/os_packages/docker_generator)

### Terraform get started
* [Terraform][terraform-install] 

#### MacOS
[Homebrew](https://brew.sh/) is a free and open-source package management system for Mac OS X. Install the official [Terraform formula](https://github.com/hashicorp/homebrew-tap) from the terminal.
```sh
# First, install the HashiCorp tap, a repository of all our Homebrew packages.
$ brew tap hashicorp/tap

# Now, install Terraform with hashicorp/tap/terraform.
$ brew install hashicorp/tap/terraform

# To update to the latest version of Terraform, first update Homebrew.
$ brew update

# Then, run the upgrade command to download and use the latest Terraform version.
$ brew upgrade hashicorp/tap/terraform
==> Upgrading 1 outdated package:
hashicorp/tap/terraform 0.15.3 -> 1.0.0
==> Upgrading hashicorp/tap/terraform 0.15.3 -> 1.0.0
```

> **Note**
> `brew install hashicorp/tap/terraform`은 서명된 바이너리를 설치하고 모든 새로운 공식 릴리스와 함께 자동으로 업데이트됩니다.

#### Windows
[Chocolatey](https://chocolatey.org/) is a free and open-source package management system for Windows. Install the [Terraform package](https://chocolatey.org/packages/terraform) from the command-line.

```sh
$ choco install terraform
```

> **Note**
> Chocolatey 및 Terraform 패키지는 HashiCorp에서 직접 유지 관리하지 않습니다.  
> 최신 버전의 Terraform은 언제나 수동 설치를 통해 업그레이드할 수 있습니다.

#### Ubuntu
HashiCorp officially maintains and signs packages for the following Linux distributions.

- Ensure that your system is up to date, and you have the gnupg, software-properties-common, and curl packages installed. You will use these packages to verify HashiCorp's GPG signature, and install HashiCorp's Debian package repository.

```bash
$ sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
```

- Add the HashiCorp [GPG key](https://apt.releases.hashicorp.com/gpg).

```bash
$ curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
```

- Add the official HashiCorp Linux repository.

```bash
$ sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
```

- Update to add the repository, and install the Terraform CLI.

```bash
$ sudo apt-get update && sudo apt-get install terraform
```


## Usage

### Inital setup

#### Store remote state on S3 backend
프로덕션 환경에서는 팀원이 인프라에 대한 협업을 위해 액세스할 수 있는 상태를 보안 및 암호화된 상태로 유지해야 합니다. 이를 수행하는 가장 좋은 방법은 상태에 대한 공유 액세스 권한이 있는 backend를 설정하여 S3 bucket에 상태를 저장하는 환경에서 Terraform을 실행하는 것입니다.

```bash
$ cd terraform-backend/
$ terraform init
$ terraform apply
```

> **Warning**
> "reservation-api-server-tfstate"이라는 S3 버킷을 생성하면 해당 버킷을 삭제할 때까지 다른 리전이나 계정에서도 동일한 이름의 버킷을 생성할 수 없습니다. 
> 이는 단순히 s3 버킷 이름이 전역적으로 고유하고 네임스페이스가 모든 AWS 계정에서 공유된다는 것을 의미합니다.

#### Terraform apply
테라폼 디렉토리에서 `apply` 명령을 실행하여 AWS에 리소스를 생성합니다.

```bash
$ cd terraform/
$ terraform init
$ terraform apply
```

#### AWS Credentials
`terraform apply`명령을 실행 후 `Error: no valid credential`을 만났다면 자격증명을 설정해야합니다.

> **Note**
> 여기서는 3가지의 방법을 제시합니다. (원하는 방법중 하나를 적용하면 됩니다.)

1. `aws configure --profile <Your Name>` 명령을 사용하여 프로필을 등록합니다.
2. export에 환경변수로 등록합니다.
   * export AWS_ACCESS_KEY_ID="Your access key"
   * export AWS_SECRET_ACCESS_KEY="Your secret key"
   * export AWS_DEFAULT_REGION="Your region"
3. `aws-login` 명령을 사용하여 간편 등록합니다.
   * [aws-login][aws-login-install] command used

### Cleanup
테라폼 디렉토리에서 `destroy` 명령을 실행하여 AWS의 리소스를 삭제합니다.

```bash
$ terraform destroy
```

## Configuration

### Secret vars file manually
민감한 정보를 파일로 지정하여 전달하려면 `secret.tfvars`파일을 생성 후 명령에 전달합니다.

```bash
$ terraform apply -var-file="secret.tfvars"
```

### Secret vars file automatically
민감한 정보파일을 자동으로 적용하려면 `*.auto.tfvars`파일을 생성합니다.
```bash
$ terraform apply
```

### What is inside the tfvars
```bash
# RDS set environment variables
db_use_data = "test"
db_username = "admin"
db_password = "secret"
rds_port = 3306

# Selected use multi_az for RDS (true/false)
multi_az = true

# Nodejs For Express || Fastify Server
server_port = 3000

# Elastic Search, Logstash, Kibana
elk_version = "8.2.0"
elastic_password = "changeme"
logstash_password = "changeme"
kibana_password = "changeme"
```

## Additional notes

### How to unlock the state file
```bash
$ terraform force-unlock <ID on Lock Info>
```

### Resource targetting for modifycation
```bash
$ terraform apply -target=<Resource>

# Example
$ terraform apply -target=aws_alb.elk_server
```

### Apply complete outputs example
 * Super secret to sensitive

```bash
api_server_elb = "api-server-514967050.ap-northeast-2.elb.amazonaws.com"
api_server_listener_target_port = 3000
cache_configure_endpoint = "superg-redis.sr25la.clustercfg.apn2.cache.amazonaws.com"
db_address = "terraform-20220601052959473200000008.cgv2m6sgcple.ap-northeast-2.rds.amazonaws.com"
db_connect_string = <sensitive>
db_name = <sensitive>
db_port = 3306
elk_server_elb = "elk-server-1070576728.ap-northeast-2.elb.amazonaws.com"
notify_queue_arn = "arn:aws:sqs:ap-northeast-2:<Account_ID>:notify-queue"
notify_queue_url = "https://sqs.ap-northeast-2.amazonaws.com/<Account_ID>/notify-queue"
notify_server_elb = "notify-server-4389281324.ap-northeast-2.elb.amazonaws.com"
```

## Going further

### Plugins and integrations
- https://github.com/nvm-sh/nvm
- https://learn.hashicorp.com/terraform

[nodejs-install]: https://github.com/nvm-sh/nvm

[docker-install]: https://docs.docker.com/get-docker/
[compose-install]: https://docs.docker.com/compose/install/
[compose-v2]: https://docs.docker.com/compose/cli-command/
[linux-postinstall]: https://docs.docker.com/engine/install/linux-postinstall/

[terraform-install]: https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started

[aws-login-install]: https://github.com/Jaeminst/AWS-Configure-Register-Script

### elk stack
- https://www.elastic.co/what-is/elk-stack
- https://github.com/deviantony/docker-elk

[elk-stack]: https://www.elastic.co/what-is/elk-stack
[xpack]: https://www.elastic.co/what-is/open-x-pack
[paid-features]: https://www.elastic.co/subscriptions
[es-security]: https://www.elastic.co/guide/en/elasticsearch/reference/current/security-settings.html
[trial-license]: https://www.elastic.co/guide/en/elasticsearch/reference/current/license-settings.html
[license-mngmt]: https://www.elastic.co/guide/en/kibana/current/managing-licenses.html
[license-apis]: https://www.elastic.co/guide/en/elasticsearch/reference/current/licensing-apis.html

[elastdocker]: https://github.com/sherifabdlnaby/elastdocker

[booststap-checks]: https://www.elastic.co/guide/en/elasticsearch/reference/current/bootstrap-checks.html
[es-sys-config]: https://www.elastic.co/guide/en/elasticsearch/reference/current/system-config.html
[es-heap]: https://www.elastic.co/guide/en/elasticsearch/reference/current/important-settings.html#heap-size-settings

[win-filesharing]: https://docs.docker.com/desktop/windows/#file-sharing
[mac-filesharing]: https://docs.docker.com/desktop/mac/#file-sharing

[builtin-users]: https://www.elastic.co/guide/en/elasticsearch/reference/current/built-in-users.html
[ls-monitoring]: https://www.elastic.co/guide/en/logstash/current/monitoring-with-metricbeat.html
[sec-cluster]: https://www.elastic.co/guide/en/elasticsearch/reference/current/secure-cluster.html

[connect-kibana]: https://www.elastic.co/guide/en/kibana/current/connect-to-elasticsearch.html
[index-pattern]: https://www.elastic.co/guide/en/kibana/current/index-patterns.html

[config-es]: ./elasticsearch/config/elasticsearch.yml
[config-kbn]: ./kibana/config/kibana.yml
[config-ls]: ./logstash/config/logstash.yml

[es-docker]: https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html
[kbn-docker]: https://www.elastic.co/guide/en/kibana/current/docker.html
[ls-docker]: https://www.elastic.co/guide/en/logstash/current/docker-config.html

[upgrade]: https://www.elastic.co/guide/en/elasticsearch/reference/current/setup-upgrade.html
