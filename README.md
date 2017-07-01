# Gravity

Gravity is the project responsible for get data from LoL API and store them in NoSQL database. This project was a part of a bigger one that I was participating with some friends :)

![gravity_diagram](img/gravity_diagram.png)

As you can see, we have two databases: _lol_dirty_data_ and _lol_clean_data_. The reason for it is the type of datas that we manipulate: **dirty** and **clean** datas.

#### Dirty data
LoL Matches’ data has a lot of informations that, most of them, we aren’t going to use for now. I called this data as **dirty**. 

Imagine a stone that inside has a diamond. We want the diamond, not the entire stone. But we need the stone to get the diamond. That’s the point. _lol_dirty_data_ store brute data (stones with diamonds). 

Gravity is like a miner: it just insert data in _lol_dirty_data_. It collects stones for other applications that know how to extract diamonds from stones.

#### Clean data
Our other database is _lol_clean_data_, where the diamonds are placed. 

All data treated by our applications should be stored in it. The applications should load datas from _lol_dirty_data_ or others integration, compile them and store in _lol_clean_data_. 

Gravity will not insert data in _lol_clean_data_.

## Data types

Nowadays Gravity load two data types: seed files and recent games.

#### Seed files
Seed files are a compilation of aleatory matches that LoL team offers to new developers. It's the easiest way to understand the data's struct. Those files are updated every 3 months or when data's struct is modified. Seed files are stored in collection `seed_match`.

#### Recent games
Recent games came from a LoL API's service ([game endpoint](https://developer.riotgames.com/api/methods#!/1078/3718)) that returns the last 10 games played from a summoner. Recent gmaes are stored in collection `recent_game`.

## Installation
Install MongoDB:
  - [Mac](https://docs.mongodb.com/manual/installation/)
  - [Linux](https://docs.mongodb.com/manual/administration/install-on-linux/)
  - [Windows](https://www.youtube.com/watch?v=dQw4w9WgXcQ)

Then install [Bundler](http://bundler.io/)

Now you can clone Gravity:
```
git clone https://github.com/eduardoeof/gravity.git
```

On Gravity's dir, install gems:
```
bundle install
```

## Run bitch, run!
On terminal, run MongoDB:
```
mongod
```

Gravity needs summonerIds to load recent games. For this, create file `create_summoners.js` with:
```
db = db.getSiblingDB('lol_clean_data')
db.summoner.insertMany(
  [
    { name: "LEP",      summonerId: "1634366"  },
    { name: "Minerva",  summonerId: "9480188"  },
    { name: "tinowns",  summonerId: "20410406" },
    { name: "pbo",      summonerId: "15723636" },
    { name: "wOs",      summonerId: "761032"   },
    { name: "Yang",     summonerId: "488056"   },
    { name: "Revolta",  summonerId: "1876119"  },
    { name: "Tockers",  summonerId: "21894688" },
    { name: "micao",    summonerId: "16404993" },
    { name: "Jockster", summonerId: "22594355" }
  ]
)
```
Then execute the file from mongo shell client:
```
mongo create_summoners.js
```

Then go to Gravity's dir and execute:
```
./gravity
```

Also can be used arguments to load specific datas:
  - `-g` or `--game`: load just recent games.
  - `-s` or `--seed`: load just seed files.
  - `-a` or `--all`: load recent games and seed files.

```
./gravity -g
```

## Finally, don't forget
Eat your vegetables.
