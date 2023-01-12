import React, {useEffect, useState} from 'react'
import TextField from '@mui/material/TextField';
import Button from '@mui/material/Button';
import Messages from './Messages'
import pck from '../../package.json'
import {makePostRequest} from "../api-actions.js";
import {api} from "../api.js";
function Input() {
    const [apiVersion, setApiVersion] = useState('0')
    const [replica, setReplica] = useState('0')
    const [state, setState] = useState([])
    const [isSent, setSending] = useState(false)
    const [data, setData] = useState({"message_id":"",
        "message": "",
        "author": ""})

    const dataPreparing = (data) => {
        let messages = data["messages"];
        let arr = []
        const response = fetch(`${api}/api/info`, {
            method: 'GET',
            headers: {'Accept': 'application/json',}
        })  .then((response) => response.json())
            .then((json) =>{
                console.log(json);
                setApiVersion(json["backend_version"]);
                setReplica(json["replica_id"]);
            })

        for (let msg of messages) {
            arr.push(
                <Messages name={msg["author"]} message={msg["message"]}/>
            )
        }
        return arr
    }
    useEffect(() => {fetch(`${api}/api/messages`,
        {method: 'GET', headers: {'Accept': 'application/json',}}).then(response => {
        if (response.status === 200 || response.status === 201) {
            return response;
        }
        throw new Error();
    }).then(response => response.json()).then(data => {setState(dataPreparing(data))});
    }, [isSent])

    return (
        <>
            <div>{`Версия backend: ${apiVersion}`}</div>
            <div>{`Версия frontend: ${pck.version}`}</div>
            <div>{`Реплика: ${replica}`}</div>
        <div>
            <div className='flex lg:flex-row flex-col  items-center justify-center  lg:space-y-0 space-y-3 lg:space-x-3 p-3'>
                <TextField
                    label="Enter Name"
                    variant="outlined"
                    size='small'
                    onChange={(evt) => {setData({...data, author: evt.target.value})}}
                />
                <TextField
                    label="Enter Message"
                    variant="outlined"
                    size='small'
                    onChange={(evt) => {setData({...data, message: evt.target.value})}}
                />
                <Button
                    variant="contained"
                    onClick={(evt) => {
                        evt.preventDefault();
                        makePostRequest(data, setSending, isSent);
                    }
                    }
                >
                    Sign
                </Button>
            </div>
            <ul className='flex flex-col items-center justify-center my-10 space-y-3 p-3'>
                {state.map(x => x)}
            </ul>
        </div>
        </>
    )
}

export default Input