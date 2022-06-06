data "aws_sqs_queue" "notify" {
  name = "notify-queue"
  depends_on = [
    aws_sqs_queue.notify
  ]
}
data "aws_sqs_queue" "notify_dlq" {
  name = "notify-queue-DLQ"
  depends_on = [
    aws_sqs_queue.notify_dlq
  ]
}

resource "aws_sqs_queue" "notify" {
  name = "notify-queue"
  visibility_timeout_seconds = 30
  delay_seconds              = 90
  max_message_size           = 2048
  message_retention_seconds  = 86400
  receive_wait_time_seconds  = 10

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.notify_dlq.arn
    maxReceiveCount = 5
  })
  redrive_allow_policy = jsonencode({
    redrivePermission = "byQueue"
    sourceQueueArns = [aws_sqs_queue.notify_dlq.arn]
  })

  tags = {
    Environment = "dev"
  }
}

resource "aws_sqs_queue" "notify_dlq" {
  name = "notify-queue-DLQ"
}

resource "aws_sqs_queue_policy" "notify_policy" {
  queue_url = aws_sqs_queue.notify.id
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Sid": "First",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "${aws_sqs_queue.notify.arn}"
    }
  ]
}
POLICY
}