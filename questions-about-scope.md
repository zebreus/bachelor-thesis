# Questions about what I want to do

I asked myself some questions about what the scope of the thesis should be.

## What do I want to do?

Exploring different ways of high-level synthesis from rust code

## Why do I want to do that?

I think Rust will be a successor to c and cpp as systems programming languages in the future. Currently HLS is usually done from cpp. I want to explore ways of doing it from rust with currently available free technologies.

## But isn't that a bit unnecessary?

Maybe, but I want to do it anyway. Also Rust could make HLS easier, because its semantics define memory and ownership more clearly than cpp. This is not in scope for my work, but that can probably be built on top of it.

## What do I mean by currently available free technologies?

## What do I mean by currently available technologies?

I don't want to write any new software for this project, because that would be way too much work for a Bachelor Thesis. Instead I would like to list, test and compare all (some) ways that HLS can be currently achieved.

## If there are already technologies for HLS from rust, why did I claim that there are none above?

As far as I know there are currently no ways to synthesize from idiomatic rust directly. There are projects like rustHDL which allows you to synthesize a (very) limited subset of rust. It is probably more similar to VHDL than to rust. Another way would be to use an opencv thing for rust, that can also target FPGAs. I haven't tested that so idk what the tradeoffs would be. There also exists tooling to synthesize from LLVM IR and rust can compile to LLVM.

## If there are already existing technologies why don't I just use them?

As far as I can see every current way is either a hacky way of gluing tools together or quite limited in the supported rust syntax. Evaluating what toolchains for HLS can be used and what features they support is the goal of this work.

## Why do you only want to look at free technologies?

There are a lot of proprietary tools by FPGA manufacturers that can be used for HLS. As far as I can see none of them directly solve the problems I’m looking at. I need to limit the scope somewhere and this seems to be an appropriate limitation, because proprietary software is usually hard to acquire, modify or evaluate. Also a lot of tooling from the manufacturers is designed to only run on windows.

## Do I want to generate RTL or gate level circuits?

For now I want to generate RTL, because the tooling to translate RTL circuits to gate level is mostly proprietary and manufacturer specific.
