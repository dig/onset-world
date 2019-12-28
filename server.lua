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

function Editor_LoadWorld()
  if EditorWorldLoaded then return end
  EditorWorldLoaded = true

  print('Server: Attempting to load world.')

  local _table = File_LoadJSONTable('world.json')
  if _table ~= nil then
    for _,v in pairs(_table) do
      if v['modelID'] ~= nil then
        Editor_CreateObject(v['modelID'], v['x'], v['y'], v['z'], v['rx'], v['ry'], v['rz'], v['sx'], v['sy'], v['sz'])
      else
        Editor_CreateDoor(v['doorID'], v['x'], v['y'], v['z'], v['yaw'])
      end
    end

    print('Server: World loaded!')
  else
    print('Server: No world.json found in root server directory, one will be made next time the server saves.')
  end
end
AddEvent('OnPackageStart', Editor_LoadWorld)

function Editor_CreateObject(objectID, x, y, z, rx, ry, rz, sx, sy, sz)
  local _object = CreateObject(objectID, x, y, z)
  if _object then
    if (rx ~= nil and sx ~= nil) then
      SetObjectRotation(_object, rx, ry, rz)
      SetObjectScale(_object, sx, sy, sz)
    end
  end
end

function Editor_CreateDoor(doorID, x, y, z, yaw)
  local _AddYaw = DoorConfig[tonumber(doorID)]
  if _AddYaw == nil then
    _AddYaw = 90
  end

  CreateDoor(doorID, x, y, z, yaw + _AddYaw)

  
end
