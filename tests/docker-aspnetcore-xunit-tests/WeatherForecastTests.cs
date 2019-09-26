using Xunit;
using static docker_aspnetcore_react.Controllers.SampleDataController;

namespace docker_aspnetcore_xunit_tests
{
    public class WeatherForecastTests
    {
        [Fact]
        public void ShouldConvertTemperatureIntoFahrenheit_FromCelcius()
        {
            // Arrange
            var weather = new WeatherForecast { TemperatureC = 32 };
            var expected = 89;
            // Act
            var actual = weather.TemperatureF;

            // Assert
            Assert.Equal(expected, actual);
        }
    }
}
