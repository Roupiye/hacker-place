package main

import (
  // "strings"
  "fmt"
  "io/ioutil"
  lua "github.com/yuin/gopher-lua"
  libs "github.com/vadv/gopher-lua-libs/inspect"
  "encoding/json"
)

type LuaArg struct {
  Value string `json:"value"`
  Type string `json:"type"`
}

func rubyAction(action string, params []LuaArg) {
  jsonData, err := json.Marshal(params)
  if err != nil {
    fmt.Println("Error:", err)
    return
  }

  fmt.Println("RUBY: " + action)
  fmt.Println(string(jsonData))
}

func customPrint(L *lua.LState) int {
  args := []LuaArg{}

  for i := 1; i <= L.GetTop(); i++ {
    arg := LuaArg{Value: L.Get(i).String(), Type: L.Get(i).Type().String()}
    args = append(args, arg)
  }

  rubyAction("print", args)

  return 0 // Number of return values
}

func gets(L *lua.LState) int {
  args := []LuaArg{}

  for i := 1; i <= L.GetTop(); i++ {
    arg := LuaArg{Value: L.Get(i).String(), Type: L.Get(i).Type().String()}
    args = append(args, arg)
  }

  rubyAction("gets", args)

  result := "userinput"

  L.Push(lua.LString(result))

  return 1 // Number of return values
}

func myGoFunction(L *lua.LState) int {
  result := "Hello from Go!"
  L.Push(lua.LString(result))
  return 1
}

func concatStringAndNumber(L *lua.LState) int {
  // Get the parameters from Lua
  str := L.CheckString(1) // CheckString verifies that the argument is a string
  num := L.CheckNumber(2) // CheckNumber verifies that the argument is a number

  // Perform some operation
  result := fmt.Sprintf("%s-%.2f", str, num)

  // Push the result back to Lua
  L.Push(lua.LString(result))

  return 1 // Number of return values
}

func DoScriptInSandbox(L *lua.LState, script string) error {
  L.SetGlobal("io", lua.LNil)

  err := L.DoString(script)

  return err
}

func runHscriptFromFile(fname string) {
  content, err := ioutil.ReadFile(fname)
  if err != nil {
    fmt.Println("Error:", err)
    return
  }

  luaCode := string(content)

  L := lua.NewState()
  libs.Preload(L)
  defer L.Close()

  L.SetGlobal("myGoFunction", L.NewFunction(myGoFunction))
  L.SetGlobal("gets", L.NewFunction(gets))
  L.SetGlobal("concatStringAndNumber", L.NewFunction(concatStringAndNumber))
  L.SetGlobal("print", L.NewFunction(customPrint))

  if err := DoScriptInSandbox(L, luaCode); err != nil {
    // fmt.Println(err.Error())
    rubyAction("print_error", []LuaArg{{err.Error(),"string"}})
  }
}

func main() {
  runHscriptFromFile("/home/me/hacker-place/app/lgo/in.lua")
}