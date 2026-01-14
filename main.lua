require "import"
import "android.hardware.Sensor"
import "android.hardware.SensorManager"
import "android.content.Context"
if proxListener then
sensorManager.unregisterListener(proxListener)
proxListener = nil
service.speak("Auto screen-off mode when near ear is now disabled")
return true
end
sensorManager = service.getSystemService(Context.SENSOR_SERVICE)
proximitySensor = sensorManager.getDefaultSensor(Sensor.TYPE_PROXIMITY)
if proximitySensor == nil then
service.speak("Device does not support proximity sensor")
return false
end
proxListener = luajava.createProxy("android.hardware.SensorEventListener", {onSensorChanged = function(event)
local distance = event.values[0]
if distance < proximitySensor.getMaximumRange() then
service.click({{"%关屏"}})
end
end,
onAccuracyChanged = function(sensor, accuracy)
end})
sensorManager.registerListener(proxListener, proximitySensor, SensorManager.SENSOR_DELAY_NORMAL)
service.speak("Auto screen-off mode when near ear is now enabled")