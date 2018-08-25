# AWS Autoscaling Template

[![Build Status](https://travis-ci.org/royge/terraform-aws-autoscaling.svg?branch=master)](https://travis-ci.org/royge/terraform-aws-autoscaling)

**WARNING:** You are fully aware that AWS resources created by this template
are not always free even during tests.

## Getting Started

1. Clone the repo

    ```
    $ git clone git@github.com:royge/terraform-aws-autoscaling.git
    ```

1. Install [terraform](https://www.terraform.io/downloads.html)

1. Initialize and validate

    ```
    $ ENV=test make init
    $ ENV=test make validate
    ```

1. Execute plan

    ```
    $ ENV=test make plan
    ```

1. Execute apply

    ```
    $ ENV=test make apply
    ```

1. Execute destroy

    ```
    $ ENV=test make destroy
    ```

## TODO

1. Unit tests
1. More usage examples
1. ?
