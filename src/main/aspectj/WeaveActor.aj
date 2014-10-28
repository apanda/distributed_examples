package sample;

import static java.lang.Thread.sleep;

import akka.dispatch.verification.DPOR;

import akka.actor.ActorRef;
import akka.actor.Actor;
import akka.actor.ActorCell;
import akka.pattern.AskSupport;
import akka.actor.ActorSystem;
import akka.dispatch.Envelope;
import akka.dispatch.MessageQueue;

import scala.concurrent.impl.CallbackRunnable;



privileged public aspect WeaveActor {
  
  DPOR dpor = new DPOR();
  
  before(ActorCell me, Object msg):
  execution(* akka.actor.ActorCell.receiveMessage(Object)) &&
  args(msg, ..) && this(me) {
	dpor.beginMessageReceive(me);
  }
  
 
 
  after(ActorCell me, Object msg):
  execution(* akka.actor.ActorCell.receiveMessage(Object)) &&
  args(msg, ..) && this(me) {
	dpor.afterMessageReceive(me);
  }
 
  
  before(MessageQueue me, ActorRef receiver, Envelope handle):
  execution(* akka.dispatch.MessageQueue.enqueue(..)) &&
  args(receiver, handle, ..) && this(me) {
	dpor.beforeEnqueue(me, receiver, handle);
  }
 
  
  before(ActorCell receiver, Envelope invocation):
  execution(* akka.dispatch.MessageDispatcher.dispatch(..)) &&
  args(receiver, invocation, ..) {
  }
  
  
  
  after(ActorCell receiver, Envelope invocation):
  execution(* akka.dispatch.MessageDispatcher.dispatch(..)) &&
  args(receiver, invocation, ..) {
  }

}