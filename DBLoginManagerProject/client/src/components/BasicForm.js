import {useState} from 'react';
import Axios from 'axios';


const BasicForm = (props) => {
  const [userName,SetUserName]  = useState('');
  const [passWord,SetPassWord]  = useState('');
  const [email,SetEmail]  = useState('');
  const [Id,SetId]  = useState('');
  const [playerName,SetplayerName]  = useState('');
  const [playerTag,SetPlayerTag]  = useState();

  


  const addAccount = () =>{
    Axios.post('http://localhost:3001/create', 
    {PlayerId:Id, PlayerName:playerName, PlayerTag:playerTag, UserName: userName, Email:email, Password: passWord}).then(() =>{ console.log('Sucess')});
    console.log('add account after');
  };


  const login = (event) =>{
    
    event.preventDefault();
    console.log(playerTag);
  }
  return (
    <div className='app'>
      <form onSubmit={login}>
        <div className='control-group'>
          <div className='form-control'>
            <label htmlFor='email'>Email</label>
            <input type='text' id='email' onChange={ (event =>{SetEmail(event.target.value)})}/>
          </div>
          <div className='form-control'>
            <label htmlFor='name'>UserName</label>
            <input type='text' id='name' onChange={ (event =>{SetUserName(event.target.value)})}/>
          </div>

          <div className='form-control'>
            <label htmlFor='pass'>Password</label>
            <input type='password' id='pass' onChange={ (event =>{SetPassWord(event.target.value)})}/>
          </div>
        </div>

        <div className='form-control'>
            <label htmlFor='Id'>ID</label>
            <input type='text' id='Id' onChange={ (event =>{SetId(event.target.value)})}/>
        </div>

        <div className='form-control'>
            <label htmlFor='PlayerName'>PlayerName</label>
            <input type='text' id='PlayerName' onChange={ (event =>{SetplayerName(event.target.value)})}/>
        </div>

        <div className='form-control'>
            <label htmlFor='PlayerTag'>PlayerTag(4 digits)</label>
            <input type='text' id='PlayerTag' onChange={ (event =>{SetPlayerTag(event.target.value)})}/>
        </div>


      </form>
      <div className='form-create-account'>
          <button onClick={addAccount}>Submit</button>
      </div>
    </div>
  );
};




export default BasicForm;
