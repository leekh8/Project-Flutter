const crypto = require("crypto");

// 비동기 방식
crypto.randomBytes(64, (err, buffer) => {
  if (err) throw err;
  const secret = buffer.toString("hex");
  console.log(secret);
});

// 동기 방식
const secretSync = crypto.randomBytes(64).toString("hex");
console.log(secretSync);
