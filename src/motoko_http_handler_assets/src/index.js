import { Actor, HttpAgent } from '@dfinity/agent';
import { idlFactory as motoko_http_handler_idl, canisterId as motoko_http_handler_id } from 'dfx-generated/motoko_http_handler';

const agent = new HttpAgent();
const motoko_http_handler = Actor.createActor(motoko_http_handler_idl, { agent, canisterId: motoko_http_handler_id });

document.getElementById("clickMeBtn").addEventListener("click", async () => {
  const name = document.getElementById("name").value.toString();
  const greeting = await motoko_http_handler.greet(name);

  document.getElementById("greeting").innerText = greeting;
});
