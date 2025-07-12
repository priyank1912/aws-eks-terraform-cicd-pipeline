using Microsoft.AspNetCore.Mvc;

namespace Backend.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class UserController : ControllerBase
    {
        [HttpPost("save-user")]
        public IActionResult SaveUser([FromBody] UserDto user)
        {
            // Simulate saving user to database
            if (string.IsNullOrEmpty(user.Username) || string.IsNullOrEmpty(user.Email))
            {
                return BadRequest("Invalid user data.");
            }

            return Ok("User saved successfully.");
        }
    }

    public class UserDto
    {
        public string Username { get; set; }
        public string Email { get; set; }
    }
}
