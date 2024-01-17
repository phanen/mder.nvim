local tl = require("toggle-checkbox").toggle_line

-- stylua: ignore
describe("toggle-checkbox tests", function()
  local asserter = function(tests)
    return function()
      for _, test in ipairs(tests) do
        if test[3] then
          assert.same(tl(test[1]), test[2])
        else
          assert.is_not.same(tl(test[1]), test[2])
        end
      end
    end
  end

  it("toggle empty", asserter {
    { "", "* ", true },
    { " ", "*  ", true },
    { "  ", "*   ", true },
  })

  it("toggle non-empty", asserter {
    { "raw line", "* raw line", true },
    { "- item line", ";* [ ] item line", true },
    { "+ [ ] box line", "+ [x] box line", true },
    { "- [x] box line", "- [ ] box line", true },
  })

  it("list symbol in sentence", asserter {
    {"c++ sucks", "* c++ sucks", true},
    {"* c++ sucks", "* [ ] c++ sucks", true},
    {"* [ ] c++ sucks", "* [x] c++ sucks", true},
  })
end)
