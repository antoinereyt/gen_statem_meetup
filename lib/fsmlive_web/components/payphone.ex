defmodule FsmliveWeb.Components.Payphone do
  use Phoenix.Component

  attr :state, :atom, values: [:idle, :waiting_credit, :waiting_dial, :on_call], required: true
  attr :screen, :atom, values: [:clear, :warning_low_credit], required: true

  def payphone(assigns) do
    ~H"""
    <svg
      width="128"
      height="128"
      style="width:100%;height:100%"
      viewBox="0 0 128 128"
      fill="none"
      xmlns="http://www.w3.org/2000/svg"
    >
      <g id="pay phone-1.1s-128px 1">
        <g id="Group">
          <path
            id="Vector"
            d="M40.4326 118.4H87.5661C89.865 118.4 92.0698 117.487 93.6954 115.861C95.321 114.236 96.2342 112.031 96.2342 109.732V35.2883H31.7658V109.732C31.7656 110.87 31.9896 111.997 32.4251 113.049C32.8606 114.101 33.499 115.056 34.3038 115.861C35.1086 116.666 36.0641 117.305 37.1157 117.74C38.1673 118.176 39.2944 118.4 40.4326 118.4Z"
            fill="white"
            stroke="#77A4BD"
            stroke-width="3.84"
            stroke-miterlimit="10"
          />
          <path
            id="Vector_2"
            d="M75.1258 109.12H52.8743C51.1375 109.12 49.4719 108.43 48.2438 107.202C47.0157 105.974 46.3258 104.308 46.3258 102.572V48.9485C46.3258 47.2117 47.0157 45.5461 48.2438 44.318C49.4719 43.0899 51.1375 42.4 52.8743 42.4H75.1271C76.8638 42.4 78.5294 43.0899 79.7575 44.318C80.9856 45.5461 81.6755 47.2117 81.6755 48.9485V102.572C81.6752 104.308 80.985 105.974 79.7567 107.202C78.5284 108.43 76.8627 109.12 75.1258 109.12Z"
            fill="#333333"
          />
          <path
            opacity={[(@state == :idle && "1") || "0"]}
            id="wire-in"
            d="M64.0256 97.0739V102.057C64.0256 104.753 62.9546 107.339 61.0481 109.245C59.1417 111.152 56.556 112.223 53.8598 112.223V112.223C51.1637 112.223 48.578 111.152 46.6716 109.245C44.7651 107.339 43.6941 104.753 43.6941 102.057V69.193"
            stroke="#E0E0E0"
            stroke-width="2.56"
            stroke-miterlimit="10"
          />
          <path
            fill={[(@screen == :warning_low_credit && "#ed8936") || "#E0E0E0"]}
            id="Top"
            d="M31.7658 18.2682V35.2896H96.2355V18.2682C96.2355 15.9692 95.3223 13.7644 93.6967 12.1389C92.0711 10.5133 89.8663 9.60001 87.5674 9.60001H40.4326C39.2944 9.60001 38.1673 9.82422 37.1157 10.2599C36.0641 10.6955 35.1086 11.334 34.3038 12.1389C33.499 12.9439 32.8606 13.8994 32.4251 14.9511C31.9896 16.0028 31.7656 17.1299 31.7658 18.2682V18.2682Z"
            stroke="#77A4BD"
            stroke-width="3.84"
            stroke-miterlimit="10"
          />
          <path
            opacity={[(@state == :idle && "1") || "0"]}
            id="phone-in"
            d="M71.3165 67.0618V58.6406C71.3165 57.2946 70.7818 56.0037 69.83 55.0519C68.8782 54.1002 67.5873 53.5654 66.2413 53.5654H61.7587C60.4127 53.5654 59.1218 54.1002 58.17 55.0519C57.2182 56.0037 56.6835 57.2946 56.6835 58.6406V67.0618C56.6835 67.689 57.193 68.1984 57.8202 68.1984C58.4474 68.1984 58.9568 68.7078 58.9568 69.335V84.9293C58.9568 85.5565 58.4474 86.0659 57.8202 86.0659C57.5188 86.0663 57.2299 86.1861 57.0168 86.3992C56.8037 86.6123 56.6839 86.9012 56.6835 87.2026V95.6237C56.6835 96.9697 57.2182 98.2606 58.17 99.2124C59.1218 100.164 60.4127 100.699 61.7587 100.699H66.2413C67.5873 100.699 68.8782 100.164 69.83 99.2124C70.7818 98.2606 71.3165 96.9697 71.3165 95.6237V87.2026C71.3162 86.9012 71.1963 86.6123 70.9832 86.3992C70.7701 86.1861 70.4812 86.0663 70.1799 86.0659C69.8785 86.0656 69.5896 85.9457 69.3765 85.7326C69.1634 85.5195 69.0435 85.2306 69.0432 84.9293V69.335C69.0432 68.7078 69.5527 68.1984 70.1799 68.1984C70.3292 68.1986 70.477 68.1693 70.615 68.1122C70.753 68.0552 70.8784 67.9714 70.984 67.8659C71.0895 67.7603 71.1733 67.6349 71.2303 67.4969C71.2874 67.359 71.3167 67.2111 71.3165 67.0618V67.0618Z"
            fill="#666666"
          />
          <path
            opacity={[(@state == :idle && "0") || "1"]}
            id="phone-out"
            d="M22.633 63.4963V55.0752C22.633 53.7292 22.0983 52.4383 21.1465 51.4865C20.1947 50.5347 18.9038 50 17.5578 50H13.0752C11.7292 50 10.4383 50.5347 9.48649 51.4865C8.5347 52.4383 8 53.7292 8 55.0752V63.4963C8 64.1235 8.50944 64.633 9.13664 64.633C9.76384 64.633 10.2733 65.1424 10.2733 65.7696V81.3638C10.2733 81.991 9.76384 82.5005 9.13664 82.5005C8.83529 82.5008 8.54637 82.6207 8.33329 82.8338C8.1202 83.0469 8.00034 83.3358 8 83.6371V92.0582C8 93.4043 8.5347 94.6952 9.48649 95.647C10.4383 96.5987 11.7292 97.1334 13.0752 97.1334H17.5578C18.9038 97.1334 20.1947 96.5987 21.1465 95.647C22.0983 94.6952 22.633 93.4043 22.633 92.0582V83.6371C22.6326 83.3358 22.5128 83.0469 22.2997 82.8338C22.0866 82.6207 21.7977 82.5008 21.4963 82.5005C21.195 82.5001 20.9061 82.3803 20.693 82.1672C20.4799 81.9541 20.36 81.6652 20.3597 81.3638V65.7696C20.3597 65.1424 20.8691 64.633 21.4963 64.633C21.6456 64.6331 21.7935 64.6038 21.9315 64.5468C22.0695 64.4897 22.1948 64.406 22.3004 64.3004C22.406 64.1948 22.4897 64.0695 22.5468 63.9315C22.6038 63.7935 22.6331 63.6456 22.633 63.4963V63.4963Z"
            fill="#666666"
          />
          <g id="Group_2">
            <path
              id="Vector_3"
              d="M43.0093 24.0461V27.5878H40.9382V17.5347H44.8602C45.6154 17.5347 46.2784 17.673 46.8518 17.9494C47.4253 18.2259 47.8656 18.6176 48.1741 19.127C48.4826 19.6352 48.6362 20.215 48.6362 20.864C48.6362 21.8496 48.2995 22.6253 47.625 23.1936C46.9504 23.7619 46.0173 24.0461 44.8256 24.0461H43.0093ZM43.0093 22.368H44.8602C45.408 22.368 45.8253 22.2387 46.1133 21.9814C46.4013 21.7242 46.5446 21.3555 46.5446 20.8768C46.5446 20.384 46.4 19.9859 46.1094 19.6826C45.8189 19.3792 45.4195 19.2218 44.9075 19.2128H43.0093V22.368Z"
              fill="#A0C8D7"
            />
            <path
              id="Vector_4"
              d="M58.24 27.5878H56.1689V23.2794H52.1305V27.5878H50.0595V17.5347H52.1305V21.6077H56.1689V17.5347H58.24V27.5878Z"
              fill="#A0C8D7"
            />
            <path
              id="Vector_5"
              d="M68.3072 22.7891C68.3072 23.7786 68.1318 24.6464 67.7824 25.3926C67.433 26.1389 66.9325 26.7136 66.281 27.1194C65.6294 27.5251 64.8832 27.7274 64.041 27.7274C63.2077 27.7274 62.464 27.5277 61.8112 27.127C61.1571 26.7264 60.6515 26.1542 60.2918 25.4118C59.9334 24.6682 59.7504 23.8131 59.7466 22.8467V22.3501C59.7466 21.3606 59.9245 20.489 60.2816 19.7363C60.6387 18.9837 61.1418 18.4064 61.7933 18.0032C62.4448 17.6 63.1885 17.399 64.0269 17.399C64.864 17.399 65.609 17.6 66.2605 18.0032C66.912 18.4064 67.4163 18.9837 67.7722 19.7363C68.1293 20.489 68.3072 21.3581 68.3072 22.3424V22.7891ZM66.208 22.3334C66.208 21.28 66.0198 20.4787 65.6422 19.9309C65.2646 19.383 64.7258 19.1091 64.0269 19.1091C63.3318 19.1091 62.7955 19.3792 62.4179 19.9206C62.0403 20.4621 61.8496 21.2544 61.8445 22.2989V22.7891C61.8445 23.8157 62.0326 24.6118 62.4102 25.1776C62.7878 25.7434 63.3306 26.0262 64.0397 26.0262C64.7347 26.0262 65.2685 25.7536 65.641 25.2083C66.0134 24.663 66.2029 23.8682 66.2067 22.8224V22.3334H66.208Z"
              fill="#A0C8D7"
            />
            <path
              id="Vector_6"
              d="M77.9866 27.5878H75.9155L71.8835 20.9741V27.5878H69.8112V17.5347H71.8822L75.9206 24.1626V17.5347H77.9853V27.5878H77.9866Z"
              fill="#A0C8D7"
            />
            <path
              id="Vector_7"
              d="M85.8432 23.2307H81.8662V25.9238H86.5331V27.5878H79.7952V17.5347H86.5203V19.2128H81.8662V21.609H85.8432V23.2307Z"
              fill="#A0C8D7"
            />
          </g>
          <path
            id="Vector_8"
            d="M46.3245 74.0838H43.4023C42.5023 74.0838 41.6392 73.7263 41.0028 73.09C40.3665 72.4536 40.009 71.5905 40.009 70.6906V64.3315C40.009 63.4316 40.3665 62.5685 41.0028 61.9321C41.6392 61.2958 42.5023 60.9382 43.4023 60.9382H46.3245V74.0838Z"
            fill="#E0E0E0"
          />
        </g>
        <path
          opacity={[(@state == :idle && "0") || "1"]}
          id="wire-out"
          d="M15 96.8617V101.841C15 104.536 16.5277 107.119 19.2469 109.025C21.9662 110.93 25.6544 112 29.5 112V112C33.3456 112 37.0338 110.93 39.7531 109.025C42.4723 107.119 44 104.536 44 101.841V69"
          stroke="#E0E0E0"
          stroke-width="2.56"
          stroke-miterlimit="10"
        />
        <g opacity={[(@state == :waiting_dial && "1") || "0"]} id="dialpad">
          <g id="Group_3">
            <path
              id="Vector_9"
              d="M64.5 76.2051C65.6729 76.2051 66.6238 75.2543 66.6238 74.0813C66.6238 72.9084 65.6729 71.9575 64.5 71.9575C63.327 71.9575 62.3762 72.9084 62.3762 74.0813C62.3762 75.2543 63.327 76.2051 64.5 76.2051Z"
              fill="#666666"
            />
            <path
              id="Vector_10"
              d="M64.5 82.4392C65.6729 82.4392 66.6238 81.4883 66.6238 80.3153C66.6238 79.1424 65.6729 78.1915 64.5 78.1915C63.327 78.1915 62.3762 79.1424 62.3762 80.3153C62.3762 81.4883 63.327 82.4392 64.5 82.4392Z"
              fill="#666666"
            />
            <path
              id="Vector_11"
              d="M64.5 88.6735C65.6729 88.6735 66.6238 87.7226 66.6238 86.5497C66.6238 85.3767 65.6729 84.4258 64.5 84.4258C63.327 84.4258 62.3762 85.3767 62.3762 86.5497C62.3762 87.7226 63.327 88.6735 64.5 88.6735Z"
              fill="#666666"
            />
            <path
              id="Vector_12"
              d="M58.266 76.2051C59.4389 76.2051 60.3898 75.2543 60.3898 74.0813C60.3898 72.9084 59.4389 71.9575 58.266 71.9575C57.093 71.9575 56.1422 72.9084 56.1422 74.0813C56.1422 75.2543 57.093 76.2051 58.266 76.2051Z"
              fill="#666666"
            />
            <path
              id="Vector_13"
              d="M58.266 82.4392C59.4389 82.4392 60.3898 81.4883 60.3898 80.3153C60.3898 79.1424 59.4389 78.1915 58.266 78.1915C57.093 78.1915 56.1422 79.1424 56.1422 80.3153C56.1422 81.4883 57.093 82.4392 58.266 82.4392Z"
              fill="#666666"
            />
            <path
              id="Vector_14"
              d="M58.266 88.6735C59.4389 88.6735 60.3898 87.7226 60.3898 86.5497C60.3898 85.3767 59.4389 84.4258 58.266 84.4258C57.093 84.4258 56.1422 85.3767 56.1422 86.5497C56.1422 87.7226 57.093 88.6735 58.266 88.6735Z"
              fill="#666666"
            />
            <path
              id="Vector_15"
              d="M70.734 76.2051C71.907 76.2051 72.8578 75.2543 72.8578 74.0813C72.8578 72.9084 71.907 71.9575 70.734 71.9575C69.5611 71.9575 68.6102 72.9084 68.6102 74.0813C68.6102 75.2543 69.5611 76.2051 70.734 76.2051Z"
              fill="#666666"
            />
            <path
              id="Vector_16"
              d="M70.734 82.4392C71.907 82.4392 72.8578 81.4883 72.8578 80.3153C72.8578 79.1424 71.907 78.1915 70.734 78.1915C69.5611 78.1915 68.6102 79.1424 68.6102 80.3153C68.6102 81.4883 69.5611 82.4392 70.734 82.4392Z"
              fill="#666666"
            />
            <path
              id="Vector_17"
              d="M70.734 88.6735C71.907 88.6735 72.8578 87.7226 72.8578 86.5497C72.8578 85.3767 71.907 84.4258 70.734 84.4258C69.5611 84.4258 68.6102 85.3767 68.6102 86.5497C68.6102 87.7226 69.5611 88.6735 70.734 88.6735Z"
              fill="#666666"
            />
            <path
              id="Vector_18"
              d="M64.5 94.9075C65.6729 94.9075 66.6238 93.9566 66.6238 92.7837C66.6238 91.6107 65.6729 90.6599 64.5 90.6599C63.327 90.6599 62.3762 91.6107 62.3762 92.7837C62.3762 93.9566 63.327 94.9075 64.5 94.9075Z"
              fill="#666666"
            />
          </g>
        </g>
        <g
          opacity={[
            (@state in [:waiting_credit, :waiting_dial, :warning_credit, :on_call] && "1") || "0"
          ]}
          id="coin"
        >
          <g id="Group_4">
            <g id="Group_5">
              <path
                id="Vector_19"
                d="M61.4077 48.1322C57.5905 48.1322 54.4852 51.1308 54.4852 54.8164C54.4852 58.502 57.5905 61.5006 61.4077 61.5006C65.225 61.5006 68.3306 58.502 68.3306 54.8164C68.3306 51.1308 65.225 48.1322 61.4077 48.1322Z"
                fill="#F8B26A"
              />
              <path
                id="Vector_20"
                d="M61.4077 46.8C56.8295 46.8 53.105 50.396 53.105 54.8164C53.105 59.2368 56.8295 62.8331 61.4077 62.8331C65.986 62.8331 69.7107 59.2368 69.7107 54.8164C69.7107 50.396 65.9857 46.8 61.4077 46.8ZM61.4077 61.5006C57.5905 61.5006 54.4852 58.502 54.4852 54.8164C54.4852 51.1308 57.5905 48.1322 61.4077 48.1322C65.225 48.1322 68.3306 51.1308 68.3306 54.8164C68.3306 58.502 65.225 61.5006 61.4077 61.5006Z"
                fill="#F5E6C8"
              />
              <path
                id="Vector_21"
                d="M62.0707 54.0618C61.0644 53.6961 60.6503 53.4562 60.6503 53.079C60.6503 52.7587 60.8988 52.4386 61.6684 52.4386C62.091 52.4386 62.4381 52.5033 62.718 52.5837C63.0851 52.6892 63.4682 52.4697 63.5633 52.1113C63.6578 51.7557 63.4337 51.399 63.066 51.3055C62.7728 51.231 62.4236 51.177 61.9999 51.1585V50.713C61.9999 50.5645 61.9388 50.422 61.83 50.317C61.7213 50.212 61.5737 50.153 61.4199 50.153C61.2661 50.153 61.1186 50.212 61.0098 50.317C60.901 50.422 60.8399 50.5645 60.8399 50.713V51.2386C59.5732 51.4785 58.8389 52.2673 58.8389 53.273C58.8389 54.3816 59.7031 54.953 60.9698 55.3646C61.8459 55.6505 62.2247 55.9249 62.2247 56.3592C62.2247 56.8167 61.7633 57.0679 61.0884 57.0679C60.6268 57.0679 60.1906 56.9814 59.8081 56.8556C59.4323 56.7319 59.026 56.9318 58.9271 57.3031L58.9129 57.3568C58.8692 57.5188 58.891 57.6907 58.9738 57.8378C59.0565 57.9848 59.1941 58.0959 59.3586 58.1487C59.7704 58.2792 60.2704 58.3721 60.7802 58.394V58.9198C60.7802 59.0683 60.8413 59.2108 60.9501 59.3158C61.0588 59.4208 61.2063 59.4798 61.3602 59.4798H61.3605C61.5143 59.4798 61.6618 59.4208 61.7706 59.3158C61.8794 59.2108 61.9405 59.0683 61.9405 58.9198V58.3139C63.3014 58.0854 64.0476 57.2168 64.0476 56.1993C64.0476 55.1706 63.4792 54.5423 62.0707 54.0618Z"
                fill="#F5E6C8"
              />
            </g>
            <g id="Group_6">
              <path
                id="Vector_22"
                d="M67.592 54.4995C63.7747 54.4995 60.6694 57.498 60.6694 61.1836C60.6694 64.8693 63.7747 67.8678 67.592 67.8678C71.4093 67.8678 74.5149 64.8693 74.5149 61.1836C74.5152 57.4977 71.4093 54.4995 67.592 54.4995Z"
                fill="#F8B26A"
              />
              <path
                id="Vector_23"
                d="M67.592 53.1669C63.0138 53.1669 59.2893 56.763 59.2893 61.1833C59.2893 65.6037 63.0141 69.2 67.592 69.2C72.1702 69.2 75.895 65.6037 75.895 61.1833C75.895 56.763 72.1702 53.1669 67.592 53.1669ZM67.592 67.8675C63.7747 67.8675 60.6694 64.869 60.6694 61.1833C60.6694 57.4977 63.7747 54.4992 67.592 54.4992C71.4093 54.4992 74.5149 57.4977 74.5149 61.1833C74.5152 64.869 71.4093 67.8675 67.592 67.8675Z"
                fill="#F5E6C8"
              />
              <path
                id="Vector_24"
                d="M68.2549 60.4287C67.2486 60.063 66.8345 59.8231 66.8345 59.4459C66.8345 59.1256 67.083 58.8056 67.8527 58.8056C68.2752 58.8056 68.6224 58.8702 68.9022 58.9506C69.2694 59.0562 69.6524 58.8366 69.7476 58.4782C69.8421 58.1226 69.6179 57.7659 69.2502 57.6724C68.957 57.5979 68.6079 57.5439 68.1842 57.5254V57.0799C68.1842 56.9314 68.1231 56.789 68.0143 56.6839C67.9055 56.5789 67.758 56.5199 67.6042 56.5199C67.4503 56.5199 67.3028 56.5789 67.194 56.6839C67.0853 56.789 67.0242 56.9314 67.0242 57.0799V57.6055C65.7575 57.8454 65.0232 58.6342 65.0232 59.64C65.0232 60.7485 65.8874 61.32 67.1541 61.7316C68.0302 62.0174 68.4089 62.2918 68.4089 62.7261C68.4089 63.1836 67.9475 63.4348 67.2727 63.4348C66.811 63.4348 66.3749 63.3483 65.9924 63.2226C65.6165 63.0988 65.2102 63.2987 65.1113 63.67L65.0971 63.7238C65.0535 63.8857 65.0752 64.0576 65.158 64.2047C65.2408 64.3517 65.3784 64.4629 65.5429 64.5156C65.9547 64.6461 66.4546 64.739 66.9644 64.7609V65.2867C66.9644 65.4352 67.0255 65.5777 67.1343 65.6827C67.2431 65.7877 67.3906 65.8467 67.5444 65.8467H67.545C67.6988 65.8467 67.8464 65.7877 67.9551 65.6827C68.0639 65.5777 68.125 65.4352 68.125 65.2867V64.6808C69.486 64.4523 70.2322 63.5838 70.2322 62.5662C70.2322 61.5375 69.6638 60.9092 68.2549 60.4287Z"
                fill="#F5E6C8"
              />
            </g>
          </g>
        </g>
      </g>
    </svg>
    """
  end

  attr :state, :atom, values: [:idle, :waiting_credit, :waiting_dial, :on_call], required: true
  attr :screen, :atom, values: [:clear, :warning_low_credit], required: true

  def card(assigns) do
    ~H"""
    <div class="flex justify-center h-32 bg-green-400">
      <.payphone state={@state} screen={@screen} />
    </div>
    """
  end

  attr :state, :atom, values: [:idle, :waiting_credit, :waiting_dial, :on_call], required: true
  attr :screen, :atom, values: [:clear, :warning_low_credit], required: true

  def playground(assigns) do
    ~H"""
    <div class="flex flex-col">
      <div class="flex justify-center items-center bg-green-400 w-64 h-64">
        <.payphone state={@state} screen={@screen} />
      </div>
      <div class="flex justify-center bg-blue-300 p-2">
        <button
          title="pick_up"
          phx-click="pick_up"
          class="mr-1 bg-green-500 hover:bg-green-600 text-gray-300 font-bold py-2 px-4 rounded"
        >
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24">
            <path
              class="fill-current h-4"
              d="M13.04 14.69l1.07-2.14a1 1 0 0 1 1.2-.5l6 2A1 1 0 0 1 22 15v5a2 2 0 0 1-2 2h-2A16 16 0 0 1 2 6V4c0-1.1.9-2 2-2h5a1 1 0 0 1 .95.68l2 6a1 1 0 0 1-.5 1.21L9.3 10.96a10.05 10.05 0 0 0 3.73 3.73zM8.28 4H4v2a14 14 0 0 0 14 14h2v-4.28l-4.5-1.5-1.12 2.26a1 1 0 0 1-1.3.46 12.04 12.04 0 0 1-6.02-6.01 1 1 0 0 1 .46-1.3l2.26-1.14L8.28 4z"
            />
          </svg>
        </button>
        <button
          title="hang_up"
          phx-click="hang_up"
          class="mr-1 bg-red-500 hover:bg-red-600 text-gray-300 font-bold py-2 px-4 rounded"
        >
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24">
            <path
              class="fill-current h-4"
              d="M13.04 14.69l1.07-2.14a1 1 0 0 1 1.2-.5l6 2A1 1 0 0 1 22 15v5a2 2 0 0 1-2 2h-2A16 16 0 0 1 2 6V4c0-1.1.9-2 2-2h5a1 1 0 0 1 .95.68l2 6a1 1 0 0 1-.5 1.21L9.3 10.96a10.05 10.05 0 0 0 3.73 3.73zM8.28 4H4v2a14 14 0 0 0 14 14h2v-4.28l-4.5-1.5-1.12 2.26a1 1 0 0 1-1.3.46 12.04 12.04 0 0 1-6.02-6.01 1 1 0 0 1 .46-1.3l2.26-1.14L8.28 4z"
            />
          </svg>
        </button>
        <button
          title="dial"
          phx-click="dial"
          class="mr-1 bg-blue-600 hover:bg-blue-700 text-gray-300 font-bold py-2 px-4 rounded"
        >
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24">
            <path
              class="fill-current h-4"
              d="M5 3h4a2 2 0 0 1 2 2v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5c0-1.1.9-2 2-2zm0 2v4h4V5H5zm10-2h4a2 2 0 0 1 2 2v4a2 2 0 0 1-2 2h-4a2 2 0 0 1-2-2V5c0-1.1.9-2 2-2zm0 2v4h4V5h-4zM5 13h4a2 2 0 0 1 2 2v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4c0-1.1.9-2 2-2zm0 2v4h4v-4H5zm10-2h4a2 2 0 0 1 2 2v4a2 2 0 0 1-2 2h-4a2 2 0 0 1-2-2v-4c0-1.1.9-2 2-2zm0 2v4h4v-4h-4z"
            />
          </svg>
        </button>
        <button
          title="add_credit"
          phx-click="add_credit"
          class="bg-orange-400 hover:bg-orange-500 text-gray-300 font-bold py-2 px-4 rounded"
        >
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24">
            <path
              class="fill-current h-4"
              d="M12 22a10 10 0 1 1 0-20 10 10 0 0 1 0 20zm0-2a8 8 0 1 0 0-16 8 8 0 0 0 0 16zm1-11v2h1a3 3 0 0 1 0 6h-1v1a1 1 0 0 1-2 0v-1H8a1 1 0 0 1 0-2h3v-2h-1a3 3 0 0 1 0-6h1V6a1 1 0 0 1 2 0v1h3a1 1 0 0 1 0 2h-3zm-2 0h-1a1 1 0 1 0 0 2h1V9zm2 6h1a1 1 0 0 0 0-2h-1v2z"
            />
          </svg>
        </button>
      </div>
    </div>
    """
  end
end
