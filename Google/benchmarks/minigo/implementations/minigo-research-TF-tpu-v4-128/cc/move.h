// Copyright 2018 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#ifndef MLPERF_SUBMISSIONS_TRAINING_V0_7_MODELS_PROD_MINIGO_CC_MOVE_H_
#define MLPERF_SUBMISSIONS_TRAINING_V0_7_MODELS_PROD_MINIGO_CC_MOVE_H_

#include <string>

#include "REDACTEDsubmissions/training/v0_7/models/prod/minigo/cc/color.h"
#include "REDACTEDsubmissions/training/v0_7/models/prod/minigo/cc/coord.h"

namespace minigo {

struct Move {
  Move() = default;
  Move(Color color, Coord c) : color(color), c(c) {}

  Color color = Color::kEmpty;
  Coord c = Coord::kInvalid;

  std::string ToSgf() const;

  bool operator==(const Move& other) const {
    return color == other.color && c == other.c;
  }
};

}  // namespace minigo

#endif  // MLPERF_SUBMISSIONS_TRAINING_V0_7_MODELS_PROD_MINIGO_CC_MOVE_H_
