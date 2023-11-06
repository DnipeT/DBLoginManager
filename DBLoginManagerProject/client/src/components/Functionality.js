import {useState} from 'react';
import Axios from 'axios';


const Functionality = (props) => {

    const [settingList,SetSettingList] = useState([]);
    const [gameStatList,SetgameStatList] = useState([]);
    const [playerStatList,SetplayerStatList] = useState([]);
    const [shopList,SetShopList] = useState([]);
    const [gameTypeList,SetGameTypeList] = useState([]);

    const setting = (event) => {
        event.preventDefault();
    
        // Make a login request to the server using Axios. params->PlayerId only 1,2,3 working because others id dont have value yet
        Axios.get('http://localhost:3001/setting', {
            params: {
                PlayerId: props.PlayerId,
            }
        })
        .then((response) => {
             console.log('AAAAAAAA success:', response.data.result);
    
            // Additional logic after successful login
            SetSettingList(response.data.result); // add data to state and show it to people
         })
         .catch((error) => {
            console.error('setting error:', error);
            // Additional error handling logic
         });
    };

    const gameStat = (event) => {
        event.preventDefault();
        // Make a login request to the server using Axios. params->PlayerId only 1,2,3 working because others id dont have value yet
        Axios.get('http://localhost:3001/gameStat', {
            params: {
                PlayerId: props.PlayerId,
            }
        })
        .then((response) => {
             console.log('AAAAAAAA success:', response.data.result);
             SetgameStatList(response.data.result); // add data to state and show it to people
         })
         .catch((error) => {
            console.error('gameStat error:', error);
        
         });
    };

    const playerStat = (event) => {
        event.preventDefault();
        // Make a login request to the server using Axios. params->PlayerId only 1,2,3 working because others id dont have value yet
        Axios.get('http://localhost:3001/playerStat', {
            params: {
                PlayerId: props.PlayerId,
            }
        })
        .then((response) => {
             console.log('AAAAAAAA success:', response.data.result);
             SetplayerStatList(response.data.result); // add data to state and show it to people
         })
         .catch((error) => {
            console.error('playerStat error:', error);
        
         });
    };

    const shop = (event) => {
        event.preventDefault();
        // Make a login request to the server using Axios. params->PlayerId only 1,2,3 working because others id dont have value yet
        Axios.get('http://localhost:3001/shop', {
            params: {
                PlayerId: props.PlayerId,
            }
        })
        .then((response) => {
             console.log('AAAAAAAA success:', response.data.result);
             SetShopList(response.data.result); // add data to state and show it to people
         })
         .catch((error) => {
            console.error('shop error:', error);
        
         });
    };

    const gameType = (event) => {
        event.preventDefault();
        // Make a login request to the server using Axios. params->PlayerId only 1,2,3 working because others id dont have value yet
        Axios.get('http://localhost:3001/gameType', {
            params: {
                PlayerId: props.PlayerId,
            }
        })
        .then((response) => {
             console.log('AAAAAAAA success:', response.data.result);
            SetGameTypeList(response.data.result); // add data to state and show it to people
         })
         .catch((error) => {
            console.error('gameType error:', error);
        
         });
    };



    return(
        <div className='Functionalities'>
            <div>
                <div>
                    <button onClick={gameStat}>Game Stats</button>

                </div>
                {gameStatList.map((val, key) => {
                    return (
                        <div key={key}>
                            <p>PlayerId: {val.PlayerId}</p>
                            <p>GameTypeName: {val.GameTypeName}</p>
                            <p>Kills: {val.Kills}</p>
                            <p>Deaths: {val.Deaths}</p>
                            <p>Assists: {val.Assists}</p>
                            <p>AverageCombatScore: {val.AverageCombatScore}</p>
                        </div>
                    );
                })}

                <div>
                    <button onClick={playerStat}>Player Stats</button>
                </div>
                {playerStatList.map((val, key) => {
                    return (
                        <div key={key}>
                            <p>PlayerId: {val.PlayerId}</p>
                            <p>HeadShotPercent: {val.HeadShotPercent}</p>
                            <p>WinLossPercent: {val.WinLossPercent}</p>
                            <p>AgentStats_AgentName: {val.AgentStats_AgentName}</p>
                            <p>AgentStats_TopMap: {val.AgentStats_TopMap}</p>
                            <p>AbilityStats_AgentName: {val.AbilityStats_AgentName}</p>
                            <p>AbilityName: {val.AbilityName}</p>
                            <p>EnemiesAffected: {val.EnemiesAffected}</p>
                            <p>AlliesAffected: {val.AlliesAffected}</p>
                        </div>
                    );
                })}
                

                <div>
                    <button onClick={setting}>Setting</button>
                    {settingList.map((val, key) => {
                        return (
                            <div key={key}>
                                <p>PlayerId: {val.PlayerId}</p>
                                <p>Graphics: {val.Graphics}</p>
                                <p>MaxFPS: {val.MaxFPS}</p>
                            </div>
                        );
                    })}

                    
                </div>

                <div>
                    <button onClick={shop}>Shop</button>
                    {shopList.map((val, key) => {
                        return (
                            <div key={key}>
                                <p>PlayerId: {val.PlayerId}</p>
                                <p>WeaponName: {val.WeaponName}</p>
                                <p>Cost: {val.Cost}</p>
                                <p>WeaponType: {val.WeaponType}</p>
                            </div>
                        );
                    })}
                </div>

                <div>
                    <button onClick={gameType}>GameType</button>
                    {gameTypeList.map((val, key) => {
                        return (
                            <div key={key}>
                                <p>PlayerId: {val.PlayerId}</p>
                                <p>GameTypeName: {val.GameTypeName}</p>
                                <p>NumberofRound: {val.NumberofRound}</p>
                            </div>
                        );
                    })}
                </div>
                {/* here the end of first div*/}
            </div>

        </div>
    )
}


export default Functionality;