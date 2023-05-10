package com.example.elasticsearch.config;

import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;


@Configuration
public class AmazonS3Config {

  private static String accessKey ="AKIAYHNWF3O62LVPH6F7";

  private static String secretKey= "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";

  private static String region = "ap-northeast-2";

  @Bean
  public AmazonS3Client amazonS3Client() {
    BasicAWSCredentials awsCredentials = new BasicAWSCredentials(accessKey, secretKey);
    return (AmazonS3Client) AmazonS3ClientBuilder.standard()
        .withRegion(region)
        .withCredentials(new AWSStaticCredentialsProvider(awsCredentials))
        .build();
  }

}
