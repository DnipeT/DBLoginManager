import React from "react";
import { ReactDOM } from "react-dom/client";
import {BrowserRouter} from "react-router-dom";
import {Routes, Route} from "react-router-dom";
import { useState, useEffect } from "react";
import Functionality from './Functionality';

import Axios from 'axios';

export default function Login(){

    const [userName,SetUserName]  = useState('');
    const [passWord,SetPassWord]  = useState('');
    const [id,SetId]  = useState();
    const [isLogin,SetIsLogin] = useState(false);


    useEffect(() => {
        console.log(id+"asdsadadsadsd"); // Log the updated value of 'id'
      }, [id]); // Watch for changes in 'id' to trigger the effect

    const login = (event) => {
        event.preventDefault();
        console.log(userName, passWord);
    
        // Make a login request to the server using Axios
        Axios.post('http://localhost:3001/login', {
          UserName: userName,
          Password: passWord
        })
          .then((response) => {
            console.log('Login success:', response.data);
           
               
            SetId(response.data.PlayerId) ;
            SetIsLogin(true);

            // Additional logic after successful login
          })
          .catch((error) => {
            console.error('Login error:', error);
            // Additional error handling logic
          });
    };


    return (
        <div className="app">
            {!isLogin &&            
             <form >
                <div className='control-group'>
                
                <div className='form-control'>
                    <label htmlFor='name'>UserName</label>
                    <input type='text' id='name' onChange={ (event =>{SetUserName(event.target.value)})}/>
                </div>

                <div className='form-control'>
                    <label htmlFor='pass'>Password</label>
                    <input type='password' id='pass' onChange={ (event =>{SetPassWord(event.target.value)})}/>
                </div>
                </div>

                <div className='form-actions'>
                    <button onClick={login} type='submit' >Enter</button> {/* type='submit' make this button is used to submite the form */}
                </div>


            </form>}
            {isLogin &&
                <div>
                    <h2>Welcome, {userName}!</h2>
                    {/*  <Functionality PlayerId = {id}/> */}
                    <Functionality PlayerId = {id}/> 

                  
                    
                </div>
            }

        </div>
    );

}