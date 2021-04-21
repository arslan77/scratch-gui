node{
    def slackResponse = send("STARTED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
    stage 'Syncing Code from GitHub'
    checkout scm
    stage 'Build Image'
    sh label: 'build', script: 'docker build -t scratch:latest .'
    reply("BUILD SUCCESSFULL: <@UEWEG106N>: scratch.robotwala.org will be down for a short time.", slackResponse.threadId, color='#e33d3d')
    stage 'Stop Old Build'
    sh label: 'remove', script: 'docker stop scratch || true && docker rm scratch || true'
    stage 'Run Container'
    sh label: 'run', script: ' docker run --rm -d --name scratch -p 122:80 scratch:latest'
    stage 'Remove Extra Images'
  //  sh label: 'remove', script: ' docker image prune -f -a'
  //  sh label: 'remove', script: ' docker image prune -f -a'
    reply("JOB COMPLETED: <@UEWEG106N>, scratch.robotwala.org is back online", slackResponse.threadId, '#5ba50b')
}
def send(String message='Started', String color='#FFFF00'){
    return slackSend(channel: "softwareteam", message: message, color: color)
}
def reply(String message, String threadId, String color='#ffb85c'){
    slackSend(
        channel: threadId,
        replyBroadcast: true,
        message: message,
        color: color
    )
}
