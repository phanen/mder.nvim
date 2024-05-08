local tl = require("mder.line").toggle_line

local a = function(tests)
  return function()
    for _, t in ipairs(tests) do
      local before, after = unpack(t)
      assert.same(tl(before), after)
    end
  end
end

describe("line tests", function()
  it(
    "toggle empty",
    a {
      { "", "* " },
      { "  ", "  * " },
    }
  )

  it(
    "tab indent",
    a { -- note: use escape, avoid :retab
      { "\t", "\t* " },
      { " \t ", " \t * " },
    }
  )

  it(
    "toggle non-empty",
    a {
      { "line", "* line" },
      { "* item line", "* [ ] item line" },
      { "+ [ ] box line", "+ [x] box line" },
      { "- [x] box line", "- [ ] box line" },
    }
  )

  it(
    "list symbol in sentence",
    a {
      { "c++ sucks", "* c++ sucks" },
      { "* c++ sucks", "* [ ] c++ sucks" },
      { "* [ ] c++ sucks", "* [x] c++ sucks" },
    }
  )

  it(
    "keep indent",
    a {
      { "  aaa", "  * aaa" },
      { "    aaa", "    * aaa" },
    }
  )

  it(
    "double item",
    a {
      { "** aaa", "* ** aaa" },
      { "**aaa", "* **aaa" },
    }
  )
end)
