const express = require("express");
const app = express();
const mysql = require("mysql");
const cors = require("cors");

app.use(cors());
app.use(express.json());

const db = mysql.createConnection({
  user: "root", // your user
  host: "localhost",
  password: "your_password-here",
  database: "your_database",
});

db.connect((err) => {
  if (err) {
    console.error("Error connecting to the database:", err);
    return;
  }
  console.log("Connected to the database!");
});

app.post("/create", (req, res) => {
  const UserName = req.body.UserName;
  const Email = req.body.Email;
  const Password = req.body.Password;
  const ID = req.body.PlayerId;
  const PlayerName = req.body.PlayerName;
  const PlayerTag = req.body.PlayerTag;
  console.log("add account inside" + PlayerTag);

  db.query(
    "INSERT INTO player (PlayerId, PlayerName, PlayerTag) VALUES (?, ?, ?)",
    [ID, PlayerName, PlayerTag],
    (err, result) => {
      if (err) {
        console.log(err);
        res.status(500).send("Error inserting value1");
        return;
      } else {
        console.log("Value1 inserted");
      }
    }
  );

  db.query(
    "INSERT INTO riotaccount (PlayerId, UserName, Email, AccountPassword) VALUES (?, ?, ?, ?)",
    [ID, UserName, Email, Password],
    (err, result) => {
      if (err) {
        console.log(err);
        res.status(500).send("Error inserting value2");
        return;
      } else {
        console.log("Value2 inserted");
        res.status(200).send("Values inserted");
      }
    }
  );
});

app.post("/login", (req, res) => {
  const UserName = req.body.UserName;
  const Password = req.body.Password;

  db.query(
    "SELECT * FROM riotaccount WHERE UserName = ? AND AccountPassword = ?",
    [UserName, Password],
    (err, result) => {
      if (err) {
        console.log(err);
        res.status(500).send("Error during login");
      } else {
        if (result.length > 0) {
          const playerId = result[0].PlayerId; // Retrieve the PlayerId from the query result
          res
            .status(200)
            .send({ message: "Login successful", PlayerId: playerId }); // Send the PlayerId in the response

          console.log(result);
          return;
        } else {
          res.status(401).send("Invalid credentials");
        }
      }
    }
  );
});

app.get("/setting", (req, res) => {
  const PlayerId = req.query.PlayerId;
  db.query(
    "SELECT * FROM settings WHERE PlayerId = ? ",
    [PlayerId],
    (err, result) => {
      if (err) {
        console.log(err);
        res.status(500).send("Error during setting");
      } else {
        if (result.length > 0) {
          const playerId = result[0].PlayerId; // Retrieve the PlayerId from the query result
          console.log(result);
          res.status(200).send({
            message: "retrieved setting data successful",
            result: result,
          }); // Send the result in the response
          return;
        } else {
          res.status(401).send("Invalid credentials");
        }
      }
    }
  );
});

app.get("/gameStat", (req, res) => {
  const PlayerId = req.query.PlayerId;
  db.query(
    "SELECT * FROM aftergamestats WHERE PlayerId = ? ",
    [PlayerId],
    (err, result) => {
      if (err) {
        console.log(err);
        res.status(500).send("Error during setting");
      } else {
        if (result.length > 0) {
          const playerId = result[0].PlayerId; // Retrieve the PlayerId from the query result
          console.log(result);
          res.status(200).send({
            message: "retrieved aftergamestats data successful",
            result: result,
          }); // Send the result in the response
          return;
        } else {
          res.status(401).send("Invalid credentials");
        }
      }
    }
  );
});

app.get("/playerStat", (req, res) => {
  const PlayerId = req.query.PlayerId;

  db.query(
    "SELECT ps.PlayerId, ps.HeadShotPercent, ps.WinLossPercent, ags.AgentName AS AgentStats_AgentName, ags.TopMap AS AgentStats_TopMap, abss.AgentName AS AbilityStats_AgentName, abss.AbilityName, abss.EnemiesAffected, abss.AlliesAffected FROM playerstats ps JOIN agentstats ags ON ps.PlayerId = ags.PlayerId JOIN abilitystats abss ON ps.PlayerId = abss.PlayerId WHERE ps.PlayerId = ?",
    [PlayerId],
    (err, result) => {
      if (err) {
        console.log(err);
        res.status(500).send("Error during playerStat retrieval");
      } else {
        if (result.length > 0) {
          console.log(result);
          res.status(200).send({
            message: "Retrieved playerStat data successfully",
            result: result,
          }); // Send the result in the response
          return;
        } else {
          res.status(401).send("Invalid credentials");
        }
      }
    }
  );
});

app.get("/shop", (req, res) => {
  const PlayerId = req.query.PlayerId;
  db.query(
    "SELECT * FROM weapon WHERE PlayerId = ? ",
    [PlayerId],
    (err, result) => {
      if (err) {
        console.log(err);
        res.status(500).send("Error during setting");
      } else {
        if (result.length > 0) {
          res.status(200).send({
            message: "retrieved shop data successful",
            result: result,
          }); // Send the result in the response
          return;
        } else {
          res.status(401).send("Invalid credentials");
        }
      }
    }
  );
});

app.get("/gameType", (req, res) => {
  const PlayerId = req.query.PlayerId;
  db.query(
    "SELECT * FROM gametype WHERE PlayerId = ? ",
    [PlayerId],
    (err, result) => {
      if (err) {
        console.log(err);
        res.status(500).send("Error during setting");
      } else {
        if (result.length > 0) {
          res.status(200).send({
            message: "retrieved gametype data successful",
            result: result,
          }); // Send the result in the response
          return;
        } else {
          res.status(401).send("Invalid credentials");
        }
      }
    }
  );
});

app.listen(3001, () => {
  console.log("Server is running on port 3001");
});
