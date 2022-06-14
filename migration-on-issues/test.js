const fs = require('fs')

function sleep(t){
  return new Promise( resolve => setTimeout(resolve, t) );
}

async function sendIssues() {
    for (let i = 46; i >= 45; i+= -1) {

        fs.readFile('issues.json', (err, data) => {  // 파일 읽기
            if (err) throw err
            
            const issues = JSON.parse(data) // json.parse로 파싱

            console.log(issues[46])
            console.log(i)
        })

        await sleep(1000);

    }
}

sendIssues()