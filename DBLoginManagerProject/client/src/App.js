import login from './components/Login';
import BasicForm from './components/BasicForm';
import { Routes, Route } from 'react-router-dom';

import Axios from 'axios';
import Login from './components/Login';

import { useNavigate } from "react-router-dom";

function App() {

  const navigate = useNavigate();


  return (
    <>
      <div className='form-create-account'>
        <button onClick={ ()=>{ navigate('CreateAccount')}}>Create Account</button>
      </div>
      <div className='form-create-account'>
        <button onClick={ ()=>{ navigate('LoginAccount')}}>Login</button>
      </div>
    <Routes>
      <Route path='/CreateAccount' element={<BasicForm />} />
      <Route path='/LoginAccount' element={<Login />} />

    </Routes>



    </>

  );
}

export default App;
