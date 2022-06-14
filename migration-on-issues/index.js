const { Octokit } = require("@octokit/core");
const fs = require('fs')
require('dotenv').config()

function sleep(t){
    return new Promise( resolve => setTimeout(resolve, t) );
}

const octokit = new Octokit({
    auth: process.env.TOKEN
})

const owner = 'Jaeminst';
const repo = 'devops-01-Final-TeamG';

async function sendIssues() {
    for (let i = 46; i >= 0; i+= -1) {

        fs.readFile('issues.json', (err, data) => {  // 파일 읽기
            if (err) throw err
            
            const issues = JSON.parse(data) // json.parse로 파싱
            const sendIssue = issues[i]
            if (sendIssue.assignee.login !== "Jaeminst") {
                sendIssue.assignee.login = ""
            }

            octokit.request(`POST /repos/${owner}/${repo}/issues`, {
                owner,
                repo,
                title: sendIssue.title,
                body: sendIssue.body,
                assignees: [
                    sendIssue.assignee.login
                ],
                // milestone: sendIssue.milestone,
                labels: [
                'good first issue'
                ]
            })

            // console.log(i)
            // console.log(issues[i])
            // console.log(issues[46])
        })
        await sleep(5000);
    }
}

sendIssues()