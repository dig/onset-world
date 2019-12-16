WorldLoaded = false

function World_LoadWorld()
  if WorldLoaded then return end
  if IsPackageStarted('sandbox') then return error('ERROR: Not loading world since sandbox package is enabled, this package should only be used when sandbox is disabled.') end
  WorldLoaded = true

  print('Server: Attempting to load world.')

  local _table = File_LoadJSONTable('world.json')
  for _,v in pairs(_table) do
    CreateObject(v['modelID'], v['x'], v['y'], v['z'], v['rx'], v['ry'], v['rz'], v['sx'], v['sy'], v['sz'])
  end

  print('Server: World loaded!')
end
AddEvent('OnPackageStart', World_LoadWorld)
