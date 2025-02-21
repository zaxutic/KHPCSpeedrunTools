state("KINGDOM HEARTS II FINAL MIX", "GLOBAL")
{
	bool load : "KINGDOM HEARTS II FINAL MIX.exe", 0x8E9D93;
	byte black: "KINGDOM HEARTS II FINAL MIX.exe", 0xAB8B87;
	bool saveload: "KINGDOM HEARTS II FINAL MIX.exe", 0xBEBCF4;
	bool fightend: "KINGDOM HEARTS II FINAL MIX.exe", 0xAD6B80;
	byte titlescreen: "KINGDOM HEARTS II FINAL MIX.exe", 0x711438;
	byte soraHP: "KINGDOM HEARTS II FINAL MIX.exe", 0x2A20C58;
}

state("KINGDOM HEARTS II FINAL MIX", "JP")
{
	bool load : "KINGDOM HEARTS II FINAL MIX.exe", 0x8E8D93;
	byte black: "KINGDOM HEARTS II FINAL MIX.exe", 0xAB7B87;
	bool saveload: "KINGDOM HEARTS II FINAL MIX.exe", 0xBEACF4;
	bool fightend: "KINGDOM HEARTS II FINAL MIX.exe", 0xAD5B80;
	byte titlescreen: "KINGDOM HEARTS II FINAL MIX.exe", 0x710438;
	byte soraHP: "KINGDOM HEARTS II FINAL MIX.exe", 0x2A1FC58;
}

init
{
	timer.IsGameTimePaused = false;
	vars.splitTimer = 0;

	if(modules.First().ModuleMemorySize == 46301184){
		version = "JP";
	}
	else{
		version = "GLOBAL";
		//46305280
	}
	print(modules.First().ModuleMemorySize.ToString());
}

startup
{
	vars.booting = false;
}

start
{

}

split
{
	if(vars.splitTimer <= 0){
		if(current.fightend && !old.fightend && current.soraHP > 0){
			vars.splitTimer = 300;
			return true;
		}
	}
	else if(!current.fightend){
		vars.splitTimer = vars.splitTimer-1;
	}
	return false;
}

exit
{
	vars.booting = true;
	timer.IsGameTimePaused = true;
}

update
{
	if(vars.booting && current.titlescreen == 1){
		vars.booting = false;
	}
}

isLoading
{
	return current.load || current.saveload || current.black==128;
}