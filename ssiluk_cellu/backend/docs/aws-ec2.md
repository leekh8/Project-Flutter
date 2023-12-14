# cellu-ec2-instance

## 인스턴스 설정

- API 호출: RunInstances

  ```
  {
    "MaxCount": 1,
    "MinCount": 1,
    "ImageId": "ami-0fe8bec493a81c7da",
    "InstanceType": "t3.micro",
    "KeyName": "cellu-ec2-instance-key",
    "EbsOptimized": true,
    "NetworkInterfaces": [
      {
        "AssociatePublicIpAddress": true,
        "DeviceIndex": 0,
        "Groups": [
          "<groupId of the new security group created below>"
        ]
      }
    ],
    "TagSpecifications": [
      {
        "ResourceType": "instance",
        "Tags": [
          {
            "Key": "Name",
            "Value": "cellu-ec2-instance"
          }
        ]
      }
    ],
    "MetadataOptions": {
      "HttpTokens": "required",
      "HttpEndpoint": "enabled",
      "HttpPutResponseHopLimit": 2
    },
    "PrivateDnsNameOptions": {
      "HostnameType": "ip-name",
      "EnableResourceNameDnsARecord": true,
      "EnableResourceNameDnsAAAARecord": false
    }
  }
  ```

## 새 보안 그룹 설정

- API 호출: CreateSecurityGroup

  ```
  {
    "GroupName": "launch-wizard-1",
    "Description": "launch-wizard-1 created 2023-11-20T00:58:24.513Z",
    "VpcId": "vpc-09134f57ecc8089e2"
  }
  ```

- API 호출: AuthorizeSecurityGroupIngress
  ```
  {
    "GroupId": "<groupId of the security group created above>",
    "IpPermissions": [
      {
        "IpProtocol": "tcp",
        "FromPort": 22,
        "ToPort": 22,
        "IpRanges": [
          {
            "CidrIp": "0.0.0.0/0"
          }
        ]
      },
      {
        "IpProtocol": "tcp",
        "FromPort": 443,
        "ToPort": 443,
        "IpRanges": [
          {
            "CidrIp": "0.0.0.0/0"
          }
        ]
      },
      {
        "IpProtocol": "tcp",
        "FromPort": 80,
        "ToPort": 80,
        "IpRanges": [
          {
            "CidrIp": "0.0.0.0/0"
          }
        ]
      }
    ]
  }
  ```
