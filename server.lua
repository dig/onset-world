WorldLoaded = false

local DoorConfig = {
  [6]=180,
  [17]=180,
  [18]=180,
  [19]=180,
  [26]=180,
  [27]=180,
  [28]=180,
  [29]=180,
  [30]=180,
  [31]=180,
  [32]=180,
  [33]=180,
  [34]=180,
  [35]=0,
  [36]=270,
  [37]=270,
  [38]=270,
  [39]=270
}

function World_LoadWorld()
  if WorldLoaded then return end
  if IsPackageStarted('sandbox') then return error('ERROR: Not loading world since sandbox package is enabled, this package should only be used when sandbox is disabled.') end
  WorldLoaded = true

  print('Server: Attempting to load world.')

  local _table = File_LoadJSONTable('world.json')
  for _,v in pairs(_table) do
    if v['modelID'] ~= nil then
      CreateObject(v['modelID'], v['x'], v['y'], v['z'], v['rx'], v['ry'], v['rz'], v['sx'], v['sy'], v['sz'])
    else
      local _AddYaw = DoorConfig[tonumber(doorID)]
      if _AddYaw == nil then
        _AddYaw = 90
      end

      CreateDoor(v['doorID'], v['x'], v['y'], v['z'], v['yaw'] + _AddYaw, true)
    end
  end

  print('Server: World loaded!')
end
AddEvent('OnPackageStart', World_LoadWorld)
