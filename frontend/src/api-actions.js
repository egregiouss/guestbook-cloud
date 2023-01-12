
export const makePostRequest = (data, setSending, isSent) => {
    const headers = new Headers();
    headers.append("Content-Type", "application/json");
    const body = JSON.stringify({
        "message": data.message,
        "author": data.author
    });

    const requestOptions = {
        method: 'POST',
        headers: headers,
        body: body,
        redirect: 'follow'
    };

    fetch("https://d5duj57ijcn5qev7lbmg.apigw.yandexcloud.net/api/messages", requestOptions)
        .then(response => {response.text();
            setSending(!isSent)
        })
        .then(result => console.log(result))
        .catch(error => console.log('error', error));

}